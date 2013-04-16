$( document ).ready( function() {
	initButtonListeners();
}); 

function initButtonListeners() {
	var buttons = [ 'accept', 'deny' ];
	for( i in buttons ) {
		$( '.'+buttons[i]+'-request' ).click( function( status ) { return function() {
			changeRequestStatus( getRequestId( this ), status );
		} }( buttons[i] ) );
	}
}

function getRequestId( buttonElem ) { return $( buttonElem ).parent().attr( 'data-id' ); }

function changeRequestStatus( id, status ) {
	$.ajax({ 
		url: 'requests/'+id+'/'+status
	}).done( function( response ) {
		reloadRequestList();
	});
}

function reloadRequestList() {
	$.ajax({
		url: '/requests'
	}).done( function( response ) {
		$( '#requests' ).html( response );
		initButtonListeners();
	});
}
