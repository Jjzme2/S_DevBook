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


	// public AccessObject function getEmptyAccessObject() {
	// 	return new models.ServerModels.AccessObject();
	// }

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
                res.setData(qryHandler.getArray());
            } else if (records == 1) {
                res.addMessage("Found one record in BaseServer.getRecordsByActivity");
                res.setData([qryHandler.getEntity()]);
            } else {
                res.addMessage("No records found.");
                res.setData([]);
            }
        } catch (any e) {
			// writeDump(var=e, abort=true);
            res.addMessage("Error Message: #e.message#");

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
            // Handle the error as appropriate for your application.
            // Logging or notifying administrators would be a good practice.
        }
		writeDump(var=res, abort=true);
        // Log or handle the result in a way suitable for your application.
        // Avoid using writeDump in production for security and performance reasons.

        return res;
    }
}
