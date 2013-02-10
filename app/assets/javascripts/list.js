// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

var lastForm;
$(document).ready( function () {
	
	

	$( '#remove-checked' ).click( function() {
		removeChecked();
	} );


	setChecking();
	setFormLoading();

	reloadList();
	
} );

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
		url: 'list/form/?user=' + $( '#list' ).attr( 'data-user' ),
		type: 'GET'
	}).done( function( response ) {
		$( '#form' ).html( response );
		$( '#form form' ).submit( function( event ) {
			submitForm( event );
		} );
		enableAddButton( false );
	} );
}

function reloadList() {
	$.ajax({
		url: 'list/list/?user=' + $( '#list' ).attr( 'data-user' ),
		type: 'GET'
	}).done( function( response ) {
		$( '#list' ).html( response );
		setChecking();
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
	}).done( function() {
		form.remove();
		enableAddButton( true );
		$( '#status' ).text( ' ' );
		reloadList();
	 } );

	return false;
}

function removeChecked() {
	//TODO: set "loading..." message

	$( 'ul#items li.checked' ).each( function() {
		$( '#status' ).text( 'Removing...' );
		$.ajax({ 
			url: 'item/delete',
			type: 'DELETE',
			data: { id: $(this).attr( 'data-id' ) } 
		}).done( function() {
			reloadList();
			$( '#status' ).text( ' ' );
		});
	} );
	
}

function checkItem( elem ) {
	if( $( elem ).is( ':checked' ) ) {
		$( elem ).parent().addClass( 'checked' );
	} else {
		$( elem ).parent().removeClass( 'checked' );
	}
}

function enableAddButton( enable ) {
	if( enable ) {
		$( '#add-new' ).removeAttr( 'disabled' );
	} else {
		$( '#add-new' ).attr( 'disabled', 'disabled' );
	}
}