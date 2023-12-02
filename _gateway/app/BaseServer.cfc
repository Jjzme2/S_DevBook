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


	public AccessObject function getEmptyAccessObject() {
		return new models.ServerModels.AccessObject();
	}

	public any function init ( ) {
		return this;
	}

	/**
	 * ----------------------------------------------------------------------------------------------
	 * Helper Functions
	 * ----------------------------------------------------------------------------------------------
	 */

	 public MessengerAccessor function messengerAccessor() {
		 return wirebox.getInstance( 'MessengerAccessor' );
	 }

	 public SuccessResponse function successResponse () {
		 return wirebox.getInstance( 'SuccessResponse' );
	 }

	 public ErrorResponse function errorResponse () {
		 return wirebox.getInstance( 'ErrorResponse' );
	 }

	/**
	 * This will validate the parameters passed and return true, if valid and false, if not.
	 *
	 * @param {struct} params - The parameters to validate.
	 * @return {boolean} - True if valid, false if not.
	 */
	package boolean function validateParams( required struct params ) {
		var requiredKeys = ['searchTerm', 'sqlType', 'searchValue'];

		for (key in requiredKeys) {
			if (!structKeyExists(params, key)) {
				throw('You must pass ' AND key AND ' to the function.');
				return false;
			}
		}

		return true;
	}





	/**
	 * ----------------------------------------------------------------------------------------------
	 * Basic Crud Functions
	 * ----------------------------------------------------------------------------------------------
	 */

	/**
	 * This will check if the instance exists from the access point.
	 *
	 * @param {string} id - The id of the instance to check.
	 * @param {any} accessPoint - The access point to check.
	 *
	 * @return {boolean} - True if the instance exists, false if not.
	 */
	public boolean function exists (
		 required string id
		,required any accessPoint
	) {
		return accessPoint.get( id ) != null;
	}

	/**
	 * This will return a list of all the objects in the access point.
	 *
	 * @param {any} accessPoint - The access point to check.
	 *
	 * @return {any} - An array of all the objects in the access point.
	 */
	public any function getAll ( required any accessPoint ) {
		var dataObj = getEmptyAccessObject();
		try {
			var data = accessPoint.list( order=orderedBy );
			dataObj.addMessage("Successfully found data in BaseServer.getAll");
			dataObj.setData(data);
		} catch ( any e ) {
			dataObj.addMessage("An error has occurred in BaseServer.getAll");
			dataObj.addError(e.message);
		}
		return dataObj;
	}

	/**
	 * This will return the object with the given id.
	 *
	 * @param   {struct} searchParams - The search parameters to use.
	 * @expects {string} searchTerm - The term to search for.
	 * @expects {string} sqlType - The sql type of the search term.
	 * @expects {string} searchValue - The value to search for.
	 * @expects {boolean} exactMatch - Whether or not to do an exact match.
	 *
	 * @return {any} - The object with the given id.
	 */
	public any function read (
		 required struct searchParams
		,required any accessPoint
	) {
		var dataObj = getEmptyAccessObject();

		validateParams(params=searchParams);

		try {
			var data = accessPoint.get(
				 searchTerm  = searchParams.searchTerm
				,sqlType     = searchParams.sqlType
				,searchValue = searchParams.searchValue
				,exactMatch  = structKeyExists(searchParams, 'exactMatch') ? searchParams.exactMatch : true
			);
			dataObj.addMessage("Successfully found data in BaseServer.read");
			// Make an attempt to set the data with the get function above. If it fails, then set the data to null.
			dataObj.setData(data);
		} catch ( any e ) {
			dataObj.addMessage("An error has occurred in BaseServer.read");
			dataObj.addMessage(e.message);
			dataObj.addError(e);
		}

		return dataObj;
	}

	/**
	 * This will return the Data Transfer Objects (DTO) from the access point that match the given search parameters.
	 *
	 * @param   {struct} searchParams - The search parameters to use.
	 * @expects {string} searchTerm - The term to search for.
	 * @expects {string} sqlType - The sql type of the search term.
	 * @expects {string} searchValue - The value to search for.
	 * @expects {boolean} exactMatch - Whether or not to do an exact match.
	 * @return {any} - The objects that match the given search parameters.
	 */
	public any function returnObjects (
		required any accessPoint
		,required struct searchParams
		,required any emptyEntity
	) {

		try {
			var data = accessPoint.get(
				 searchTerm  = searchParams.searchTerm
				,sqlType     = searchParams.sqlType
				,searchValue = searchParams.searchValue
				,exactMatch  = structKeyExists(searchParams, 'exactMatch') ? searchParams.exactMatch : true
			);
			var dataObj = messengerAccessor().init(
				caller='BaseServer.returnObjects'
				,returnedQuery=data
				,messages=["Successfully found data in BaseServer.returnObjects"]
			);
			dataObj.addMessage("Successfully found data in BaseServer.returnObjects");
			// writeDump(var=dataObj, abort=true);
		} catch ( any e ) {
			var dataObj = messengerAccessor().init(
				caller='BaseServer.returnObjects'
				,messages=["An error has occurred in BaseServer.returnObjects", e.message]
			);
		}

		return serializeJSON(dataObj.read());





		// OLD CODE
		var response = {};
		validateParams(params=searchParams);


		var entities = [];
		try {
			var data = accessPoint.get(
				 searchTerm  = searchParams.searchTerm
				,sqlType     = searchParams.sqlType
				,searchValue = searchParams.searchValue
				,exactMatch  = structKeyExists(searchParams, 'exactMatch') ? searchParams.exactMatch : true
			);


			// return data;

			queryEach(data, (row) => {
				var entity = {};
				entity = populator.populateFromStruct(
					target = duplicate(emptyEntity)
					,memento = row
				);
				// arrayAppend(entities, entity.get());
				arrayAppend(entities, entity.read());
			});

			response = successResponse(
				// data = data
				data = entities
				,successMessage = ''
				,functionName = 'BaseServer.returnObjects'
			)
		} catch ( any e ) {
			response = errorResponse(
				error = e
				,functionName = "BaseServer.returnObjects"
			)
		}
		return response;
	};
}
