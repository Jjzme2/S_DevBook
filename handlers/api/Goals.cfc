/**
 * @Author Jj Zettler
 * @Description This will be the API Handler for the Goal Object
 * @date 9/21/2023
 * @version 0.1
 * @Find = Goal
 */
component extends="../BaseHandler" {

	property name="dataServer" inject="GoalServer";
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


	variables.dataServerName = "Goals";
	variables.pathToThis = "handlers/api/#variables.dataServerName#/";




	/**
	 * Main entry point for the handler, Lists all gratitude entries
	 */
	remote function index( event, rc, prc ){

	// Try to get a response from the server
		try{
			var serverResponse = dataServer
				.getRecordsByActivity(
					status=1
					,dataServerName=variables.dataServerName
				);


			if( serverResponse.getSuccess() ) {
				var dataObjects = serverResponse.getData();
				var dataToReturn = [];

				if( isArray(dataObjects))
					for( obj in dataObjects ){
						arrayAppend(dataToReturn, obj.read());
					}
				else{
					arrayAppend(dataToReturn, dataObjects.read());
				}
				event.renderData( type="json", data=dataToReturn );



				if( isJSON (dataToReturn ) )
				{
					// event.renderData( type="json", data=dataToReturn );
				}
				else
				{
					// writeDump(var=dataToReturn, label="Not valid JSON", abort=true);

					// event.renderData(type="text", data="Data returned is not JSON", statusCode="500");
				}
				// !Create a way to render the object as a JSON object, currently we are returning the columns from the DB
			} else { return new models.ServerModels.Logs.ErrorLog().init(
				message="The Server Response has encountered an error"
				,source="GoalHandler"
				,error={'Messages': serverResponse.getMessages(),'Called By': serverResponse.getCaller()})
				// !Create an error struct that will return if successful, and a custom error (See above) if not.
				// ,error=serverResponse.getErrorStruct())
				.dump();
			}
		}catch( any e ){
			writeDump(var=e, abort=true);
			return new models.ServerModels.Logs.ErrorLog().init(message="ERROR", source="GoalHandler", error=e).dump();
		}
	}

	remote function createNew( event, rc, prc ){

		var objectData = {
			name=rc.name
			,description=rc.description
			,active=rc.active
			,statusId=rc.statusId
			,notes=rc.notes
			,dueDate=rc.dueDate
			,tasks=rc.tasks
			,tags=rc.tags
			,motivationId=rc.motivationId
		};

		var serverResponse = dataServer.create( dataServerName=variables.dataServerName, data=objectData );

		if( serverResponse.getSuccess() ){
			event.renderData( type="json", data=serverResponse.getData().read() );
		} else {
			return new models.ServerModels.Logs.ErrorLog().init(
				message="The Server Response has encountered an error"
				,source="GoalHandler"
				,error={'Messages': serverResponse.getMessages(),'Called By': serverResponse.getCaller()})
				// !Create an error struct that will return if successful, and a custom error (See above) if not.
				// ,error=serverResponse.getErrorStruct())
				.dump();
		}
	}


	remote function getEmpty( event, rc, prc ){
		var dataObject = dataServer.getEmpty( dataServerName=variables.dataServerName );
		event.renderData( type="json", data=dataObject.read() );
	}
}
