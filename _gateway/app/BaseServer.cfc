/**
 * This will be the service that will handle all the BASE SERVER(SERVICE) functions.
 *
 * @Authors Jj Zettler
 * @date    9/09/2023
 * @version 0.1
 */
component
	singleton
	accessors = "true"
	name      = "BaseServer"
{

	property
		name   = "populator"
		inject = "wirebox:populator";
	property
		name   = "wirebox"
		inject = "Wirebox";

	property
		name   = "stringUtil"
		inject = "stringService";

	property
		name   = "objectUtil"
		inject = "ObjectService";

	public any function init ( ) {
		return this;
	}

    /**
     * Helper Functions
     */

    /**
     * Instantiate a ServerResponse object.
     */
    public ServerResponse function serverResponse() {
		var newResponse = objectUtil.getObject('ServerResponse');
		return newResponse;
    }

	/**
	 * Get an Empty object as the data of Data from the server response.
	 *
	 * @param dataServerName Required string, data server name.
	 *
     * @return ServerResponse  Response object with query results.
	 */
	public any function getEmpty(required string dataServerName) {
		var res = serverResponse().init(
			server   = arguments.dataServerName,
			caller   = "BaseServer.getEmpty"
		);

		// Get the Accessor Object
		try {
			var qryHandler = accessPoint.getEmpty();
			res.setData(qryHandler.getEntityAsObject(this.getEmpty()));
		} catch (any e) {
			createResponseFromError(e, res);
			// Handle the error as appropriate for your application.
			// Logging or notifying administrators would be a good practice.
		}
		// Log or handle the result in a way suitable for your application.
		// Avoid using writeDump in production for security and performance reasons.
		// writeDump(var=res, abort=true)
		return res;
	}

    /**
     * Get records by activity status and data server name.
     *
     * @param status           Required boolean, activity status.
     * @param dataServerName   Required string, data server name.
     * @return ServerResponse  Response object with query results.
     */
    public ServerResponse function getRecordsByActivity(required boolean status, required string dataServerName) {
        var res = serverResponse().init(
            server   = arguments.dataServerName,
            caller   = "BaseServer.getRecordsByActivity"
        );

        // Get the Accessor Object
        try {
            var qryHandler = accessPoint.getByActivityStatus(status);
            var records    = qryHandler.getRecordCount();

            if (records > 1) {
                res.addMessage("Found #records# records in BaseServer.getRecordsByActivity");
                res.setData(qryHandler.getArrayOfObjects(this.getEmpty(arguments.dataServerName)));
			} else if (records == 1) {
                res.addMessage("Found one record in BaseServer.getRecordsByActivity");
				res.setData(qryHandler.getEntityAsObject(this.getEmpty(arguments.dataServerName)));
            } else {
                res.addMessage("No records found.");
                res.setData([]);
            }
        } catch (any e) {
			createResponseFromError(e, res);
            // Handle the error as appropriate for your application.
            // Logging or notifying administrators would be a good practice.
        }
        // Log or handle the result in a way suitable for your application.
        // Avoid using writeDump in production for security and performance reasons.
		// writeDump(var=res, abort=true)
        return res;
    }


	// !Creation Attempt:
	/**
	 * Create a new record in the database.
	 * @param dataServerName Required string, data server name.
	 * @param data           Required struct, data to be inserted.
	 *
	 * @return ServerResponse  Response object with query results.
	 */
	public ServerResponse function create(required string dataServerName, required struct data) {
		var res = serverResponse().init(
			server   = arguments.dataServerName,
			caller   = "BaseServer.create"
		);

		// Get the Accessor Object
		try {
			var obj = populator.populateFromStruct(getEmpty(dataServerName), arguments.data);
			var qryHandler = accessPoint.create(entity=obj);

			if(qryHandler.getRecordCount() == 1) {
				res.setData( qryHandler.getEntityAsObject( this.getEmpty( arguments.dataServerName ) ) );
			}else if (qryHandler.getRecordCount() > 1) {
				res.setData( qryHandler.getArrayOfObjects( this.getEmpty( arguments.dataServerName ) ) );
			} else {
				res.setData = [];
				res.AddMessage( "No records found." );
			}
		} catch (any e) {
			createResponseFromError(e, res);
			// Handle the error as appropriate for your application.
			// Logging or notifying administrators would be a good practice.
		}
		// Log or handle the result in a way suitable for your application.
		// Avoid using writeDump in production for security and performance reasons.
		// writeDump(var=res, abort=true)
		return res;
	}













	private function createResponseFromError(any e, required ServerResponse res) {
		res.addMessage("Error Message: #e.message#");
		res.addMessage("Error Details: #e.detail#");
		// additional, code, Detail, ErrorCode, Extended_Info, ExtendedInfo, Message, StackTrace, TagContext, type
		for(context in e.TagContext) {
			var msg = '
				|LOCATION|       = #context.Template# --
				|LINE|           = #context.Line# --
				|CODEPRINTPLAIN| = #context.CodePrintPlain#
			';
			res.addMessage(msg);
		}
		res.addMessage("Error Details: #e.message#");
		res.setSuccess(false);
	}
}
