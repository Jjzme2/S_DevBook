/**
 * @Author Jj Zettler
 * @Description This will be the API Handler for the Task Object
 * @date 9/21/2023
 * @version 0.1
 * @Find = Task
 */
component extends="../BaseHandler" {

	property name="dataServer" inject="TaskServer";

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


	variables.dataServerName = "Tasks";
	variables.pathToThis = "handlers/api/#variables.dataServerName#/";




	/**
	 * Main entry point for the handler, Lists all gratitude entries
	 */
	remote function index( event, rc, prc ){

	// Try to get a response from the server
		try{
			var serverData = dataServer.getRecordsByActivity(status=1, dataServerName=variables.dataServerName);
			var retrievedData = serverData.getData();

			var apiResponse = wirebox.getInstance("APIResponse").init(
				// data = retrievedData
				data = ""
			)

			// Retrieved Data should be a part of the new APIResponse object.

			// writeDump(var=retrievedData, abort=true);


			event.renderData( type="json", data=apiResponse );

			// All of these are kept to remind me of the structure of the data

			// var serverName = serverData.getServer();
			// var serverTimeStamp = serverData.getCreatedOn();
			// var serverMessages = serverData.getMessages();
			// var serverCaller = serverData.getCaller();
		}catch( any e ){
			// !Check if this works. Might need to adjust anyway based on new flow.
			// return wirebox.getInstance("ErrorResponse").init(error=e, caller="#variables.dataServerName#.index", dataServerName=variables.dataServerName);
			writeDump(var=e, abort=true);
		}
	}
}
