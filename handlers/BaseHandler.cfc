/**
 * My RESTFul Event Handler
 */
component extends = "coldbox.system.RestHandler" {

	// Don't forget to Map in config/Wirebox.cfc where applicable.

	property
		name   = "populator"
		inject = "wirebox:populator";
	property
		name   = "logbox"
		inject = "logbox:logger:api";
	property
		name   = "stringUtil"
		inject = "StringService";

	// property
	// 	name   = "converter"
	// 	inject = "ConversionService";



	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only      = '';
	this.prehandler_except    = '';
	this.posthandler_only     = '';
	this.posthandler_except   = '';
	this.aroundHandler_only   = '';
	this.aroundHandler_except = '';

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = { };


	/**
	 * Handle PreFlight Requests
	 */
	remote function preFlight (
		 event
		,rc
		,prc
	) {
		var message = 'PreFlight Request Made @ #now( )#';
		// logService.sendLog(message="PreFlight Request Made @ #now()#", prefix="BaseHandler");
		if ( logbox.canInfo( ) ) {
			logbox.info( message );
		}
	}

	public function getSuccessfulResponse(array messages, string caller, any data)
	{
		return new models.ServerModels.Responses.SuccessResponse()
			 .init(
				messages=arguments.messages ?: []
				,data=arguments.data ?: {}
				,caller=arguments.caller ?: 'BaseHandler'
			 );
	}

	public function getErrorResponse(array messages, string caller, any error)
	{
		return new models.ServerModels.Responses.ErrorResponse()
			 .init(
				messages=arguments.messages ?: []
				,error=arguments.error ?: {}
				,caller=arguments.caller ?: 'BaseHandler'
			 );
	}



	/**
	 * Send a response from the api call.
	 *
	 * @param {object} event - The ColdBox event object.
	 * @param {struct} data - The data to include in the response.
	 * @param {string} message - The message to send.
	 * @param {number} statusCode - The HTTP status code.
	 */
	public function sendResponse (
		 required event
		,requiredmessage = 'A message from the server'
		,data            = { }
		,statusCode      = 404
	) {
		event
			.getResponse( )
			.setData( data )
			.addMessage( message )
			.setStatusCode( statusCode );
	}

}
