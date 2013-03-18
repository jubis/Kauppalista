// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


var listID;
function listPageReady() {
	listID = $( '#list' ).attr( 'data-list' );

	$( '#remove-checked' ).click( function() {
		removeChecked();
	} );

	$.cookie.json = true;
	if( $.cookie( 'checked' ) == undefined ) {
		$.cookie( 'checked', [] );
	}
	console.log( $.cookie( 'checked' ) );
	//$.cookie( 'checked', [] );

	setChecking();
	setFormLoading();

	reloadList();
}

function setFormLoading() {
	$( '#add-new' ).click( function() {
		if( !$( '#form' ).children.length == 0 ) {
			createNewForm();	
		}
	} );
}

function setChecking() {
	$( '.check' ).click( function() {
		checkItem( this );
	} );
}

function setItemDeleting() {
	$( '.delete-item' ).click(  function() {
		itemID = $( this ).parent().attr( 'data-id' );
		$.ajax({
			url: '/items/' + itemID,
			type: 'DELETE'
		}).done( function() {
			reloadList();
		});
	} );
}

function createNewForm() {
	$.ajax({
		url: '/items/new/?list_id=' + listID,
		type: 'GET'
	}).done( function( response ) {
		doIfLoggedIn( response, function() {
			$( '#form' ).html( response );
			$( '#form form' ).submit( function( event ) {
				submitForm( event );
			} );
			$( '#form #cancel' ).click( function( event ) {
				removeForm( event );
			} );
			enableAddButton( false );
		} );
	} );
}

function reloadList() {

	$.ajax({
		url: listID + '/?partial=true',
		type: 'GET'
	}).done( function( response ) {
		doIfLoggedIn( response, function() {
			$( '#list' ).html( response );
			setChecking();
			setItemDeleting();
			checkItemsByCookie();
		} );
	} );
}

function submitForm( event ) {
	event.preventDefault();
	var form = $( '#form form' );

	var data = new Object();
	$( '#form input' ).each( function() {
		data[ $(this).attr( 'name' ) ] = $(this).val();
	} );

	//TODO: set "loading..." message
	$( '#status' ).text( 'Adding...' );
	$.ajax({ 
		url: form.attr( 'action' ),
		type: 'POST', 
		data: data 
	}).done( function( response ) {
		doIfLoggedIn( response, function() {
			form.remove();
			enableAddButton( true );
			$( '#status' ).text( ' ' );
			reloadList();
		} );
	 } );

	return false;
}

function removeForm( event ) {
	event.preventDefault();
	$( '#form form' ).remove();
	enableAddButton( true );
}

function removeChecked() {
	//TODO: set "loading..." message

	$( 'ul#items li.checked' ).each( function() {
		var itemID = $(this).attr( 'data-id' );

		$( '#status' ).text( 'Removing...' );
		$.ajax({ 
			url: '/items/' + itemID,
			type: 'DELETE'
		}).done( function( response ) {
			doIfLoggedIn( response, function() {
				reloadList();
				$( '#status' ).text( ' ' );
			} );
		});
	} );
	
}

function checkItem( elem ) {
	li = $( elem ).parent();
	itemId = parseInt( li.attr( 'data-id' ) );

	var checked = $.cookie( 'checked' );

	if( $( elem ).is( ':checked' ) ) {
		li.addClass( 'checked' );
		li.attr( 'data-checked', 'true' );

		if( checked.indexOf( itemId ) == -1 ) {
			checked.push( itemId );
		}
	} else {
		li.removeClass( 'checked' );
		li.attr( 'data-checked', 'false' );
		
		if( checked[ checked.indexOf( itemId ) ] ) {
			checked.splice( checked.indexOf( itemId ), 1 );
		}
	}

	$.cookie( 'checked', checked );
}

function checkItemsByCookie() {
	var checked = $.cookie( 'checked' );
	for( item in checked ) {
		element = $( 'li[data-id="'+checked[item]+'"] input[type=checkbox]' );
		console.log( element );

		element.prop( 'checked', true );
		checkItem( element );
	}
}

function enableAddButton( enable ) {
	if( enable ) {
		$( '#add-new' ).removeAttr( 'disabled' );
	} else {
		$( '#add-new' ).attr( 'disabled', 'disabled' );
	}
}

function doIfLoggedIn( response, job ) {
	if( response != "login required" ) {
		job();
	} else {
		document.location.href = "/login"
	}
}