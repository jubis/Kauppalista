// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/



function listPageReady() {
	$( '#remove-checked' ).click( function() {
		removeChecked();
	} );


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
	$( '.check' ).each( function() {
		checkItem( this );
	} );
}

function createNewForm() {
	$.ajax({
		url: 'list/form/',
		type: 'GET'
	}).done( function( response ) {
		doIfLoggedIn( response, function() {
			$( '#form' ).html( response );
			$( '#form form' ).submit( function( event ) {
				submitForm( event );
			} );
			enableAddButton( false );
		} );
	} );
}

function reloadList() {
	$.ajax({
		url: 'list/list/',
		type: 'GET'
	}).done( function( response ) {
		doIfLoggedIn( response, function() {
			$( '#list' ).html( response );
			setChecking();
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

function removeChecked() {
	//TODO: set "loading..." message

	$( 'ul#items li.checked' ).each( function() {
		$( '#status' ).text( 'Removing...' );
		$.ajax({ 
			url: 'items/delete',
			type: 'DELETE',
			data: { id: $(this).attr( 'data-id' ) } 
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
	if( $( elem ).is( ':checked' ) ) {
		li.addClass( 'checked' );
		li.attr( 'data-checked', 'true' );
	} else {
		li.removeClass( 'checked' );
		li.attr( 'data-checked', 'false' );
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