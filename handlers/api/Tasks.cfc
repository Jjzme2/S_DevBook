/**
 * @Author Jj Zettler
 * @Description This will be the API Handler for the Task Object
 * @date 9/21/2023
 * @version 0.1
 * @Find = Task
 */
component extends="../BaseHandler" {

	property name="dataServer" inject="TaskServer";

	// property name="responder" inject="ResponseService";

	property name="response"  inject="ServerModels/Responses/BaseResponse";


	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only      = "";
	this.prehandler_except    = "";
	this.posthandler_only     = "";
	this.posthandler_except   = "";
	this.aroundHandler_only   = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	variables.pathToThis = "handlers/api/Tasks/";


	/**
	 * Main entry point for the handler, Lists all gratitude entries
	 */
	remote function index( event, rc, prc ){

		var callerLocation = "#variables.pathToThis#index";

		try{
			// var target= dataServer.getByActivity(1).getData();
			var target= dataServer.getByActivity(1);
			successMessages = ["Active Tasks Retrieved"];

			writeDump(var=target, abort=true);

			var apiResponse = getSuccessfulResponse (
				messages=successMessages
				,caller=callerLocation
				,data=target
			)
			event.renderData( type="json", data=apiResponse );
		}catch( any e ){
			var errorMessages = ["Error Retrieving Active Tasks", e.message];

			var apiResponse = getErrorResponse (
				messages=errorMessages
				,caller=callerLocation
				,error=e
			 );
			event.renderData( type="json", data=apiResponse );
		}

	}
}
