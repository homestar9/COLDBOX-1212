component extends="coldbox.system.EventHandler" {

    property name="logger" inject="logbox:logger:{this}";

    /**
	 * Default Action
	 */
	function index( event, rc, prc ){
		prc.welcomeMessage = "Welcome to ColdBox!";
		event.setView( "main/index" );
	}

	function run( event, rc, prc ) {

        prc.user = getInstance( "User" );
        prc.user.setFirstName( createUuid() );
        prc.user.setLastName( createUuid() );
        prc.user.setUpdatedDate( now() );

        // attempt to save the entity via async
        var f = async().newFuture( function() {
            
            logger.warn( "I started!" );

            sleep( 2000 ); // ensure this happens after the request

            prc.user.save();
            logger.warn( "I finished!" );
                
        } ).then( ( data ) => {
            logger.warn( "I am all done!" );
        } );

        return prc.user.getMemento();

    }

    private function sendEmail( event, rc, prc ) {

        prc.userService.sendEmail( prc.baseUrl );

    }

	/**
	 * --------------------------------------------------------------------------
	 * Implicit Actions
	 * --------------------------------------------------------------------------
	 * All the implicit actions below MUST be declared in the config/Coldbox.cfc in order to fire.
	 * https://coldbox.ortusbooks.com/getting-started/configuration/coldbox.cfc/configuration-directives/coldbox#implicit-event-settings
	 */

	function onAppInit( event, rc, prc ){
	}

	function onRequestStart( event, rc, prc ){
	}

	function onRequestEnd( event, rc, prc ){
	}

	function onSessionStart( event, rc, prc ){
	}

	function onSessionEnd( event, rc, prc ){
		var sessionScope     = event.getValue( "sessionReference" );
		var applicationScope = event.getValue( "applicationReference" );
	}

	function onException( event, rc, prc ){
		event.setHTTPHeader( statusCode = 500 );
		// Grab Exception From private request collection, placed by ColdBox Exception Handling
		var exception = prc.exception;
		// Place exception handler below:
	}

}
