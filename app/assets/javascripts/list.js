// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

var lastForm;
$(document).ready( function () {
	
	$( '#add-new' ).click( function() {
		console.log( $( '#form-new' ).is( 'div' ) );
		if( !$( '#form-new' ).is( 'div' ) ) {
			createNewForm();	
		}
	} );

	$( '#remove-checked' ).click( function() {
		removeChecked();
	} );


	setChecking();

	
} );

function setChecking() {
	$( '.check' ).click( function() {
		checkItem( this );
	} );
	$( '.check' ).each( function() {
		checkItem( this );
	} );
}

function createNewForm() {
	lastForm = $( '#form' ).clone().show().attr( 'id', 'form-new' );
	lastForm.appendTo('#wrapper');

	lastForm.submit( function( event ) {
		submitForm( event );
	} );

	enableAddButton( false );
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
	var form = $( '#form-new form' );

	var data = new Object();
	$( '#form-new input' ).each( function() {
		data[ $(this).attr( 'name' ) ] = $(this).val();
	} );

	$.ajax({ 
		url: form.attr( 'action' ),
		type: 'POST', 
		data: data 
	}).done( function() {
		lastForm.remove();
		enableAddButton( true );
		reloadList();
	 } );

	return false;
}

function removeChecked() {
	$( 'ul#items li.checked' ).each( function() {
		$.ajax({ 
			url: 'item/delete',
			type: 'DELETE',
			data: { id: $(this).attr( 'data-id' ) } 
		}).done( function() {
			reloadList();
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