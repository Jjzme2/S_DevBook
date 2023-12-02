/**
 * @Author Jj Zettler
 * @Description This will be the service that will handle all the related functions for this named object.
 * @date 9/21/2023
 * @version 0.1
 * @Find = Task
 */
component singleton accessors="true" name="TaskServer" extends="BaseServer" {

	property name="accessPoint" inject="TaskAccess";

	/**
	* ----------------------------------------------------------------------------------------------
    * OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/











	/** Private functions for this service. */


	/** Common functions for this service. */

	/**
	 * This will get an empty TaskDTO.
	 * @return An empty Task DTO.
	 */
	public TaskDTO function getEmpty()
	{
		return new models.DTO.TaskDTO(); // Check path
	}


	public function getByActivity(required boolean status)
	{
		var data = accessPoint.getByActivityStatus(status);


		/*
		*
		addColumn, addRow, columnArray, columnCount, columnData, columnExists, columnList, currentRow, deleteColumn, deleteRow, duplicate, each, every, filter, getCell, getCellByIndex, getRow, keyExists, map, recordCount, reduce, rowByIndex, rowData, rowDataByIndex, setCell, setRow, slice, some, sort, toJson, valueArray, valueList
		*
		*/

		// var variableToDump = data.valueList( "id" ); // CSV of IDs -- A column from the query

		// var variableToDump = deserializeJson(data.toJson()); // Json string of the query -- deserializeJSON to convert to CFML object


		// var variableToDump = data.recordCount; // Number of records returned

		// !Returns a query object with three empty rows.
		// var variableToDump = data.map((row) => {
		// 	row.notes = deserializeJson(row.notes);

		// 	return populator.populateFromStruct(
		// 		target = getEmpty(),
		// 		memento = row
		// 	)
		// });

		// var variableToDump = data.each((row) => {
		// 	row.notes = deserializeJson(row.notes);

		// 	var queryObj =  populator.populateFromStruct(
		// 		target = getEmpty(),
		// 		memento = row
		// 	);

		// 	return queryObj;
		// 	// writeDump(var=queryObj, abort=true);
		// });
		var variableToDump = data; // QueryHandler object

		writeDump(var=variableToDump, abort=true);


		var successMessages =
		[
			"TaskServer.getByActivity: Success"
			,"TaskServer.getByActivity: #data.recordCount# records found"
		]

		var messengerAccessor =
			messengerAccessor().init (
				caller="TaskServer.getByActivity"
				,returnedQuery=variableToDump
				,messages = successMessages
			);



		return messengerAccessor;
	}





















	public function list(){
		return getAll( accessPoint = accessPoint, orderedBy={'column': 'name', 'direction': 'asc'} ); // Doesn't seem to order'
	}

// Searches

	public function getById(required string value)
	{
		var searchParams = {
			searchTerm  : "id"
			,sqlType 	: "cf_sql_varchar"
			,searchValue: value
		};

		var task =
		populator.populateFromStruct(
			target = getEmpty(),
			memento = read(accessPoint = accessPoint, searchParams = searchParams).contents
		)

		return task;

		// return read( accessPoint = accessPoint, searchParams = searchParams );
	}

	public function getByName(required string value)
	{
		var searchParams = {
			searchTerm  : "name"
			,sqlType 	: "cf_sql_varchar"
			,searchValue: value
		};

		var task =
		populator.populateFromQuery(
			target = getEmpty(),
			qry = read(accessPoint = accessPoint, searchParams = searchParams).contents
		)

		return task;

		// return read( accessPoint = accessPoint, searchParams = searchParams );
	}



	public function getByCreatedDate(required date value)
	{
		var searchParams = {
			searchTerm  : "creationDate"
			,sqlType 	: "cf_sql_datetime"
			,searchValue: value
			,relationship: "on"
		};
		var task =
		populator.populateFromQuery(
			target = getEmpty(),
			qry = readByDate(accessPoint = accessPoint, searchParams = searchParams).contents
		)

		return task;

		// return readByDate( accessPoint = accessPoint, searchParams = searchParams );
	}

	public function getByModifiedDate(required date value)
	{
		var searchParams = {
			searchTerm  : "recentChangeDate"
			,sqlType 	: "cf_sql_datetime"
			,searchValue: value
			,relationship: "on"
		};

		var entities = returnObjects(
			accessPoint=accessPoint
			,searchParams=searchParams
			,emptyEntity=getEmpty()
		);

		return entities;

		// return readByDate( accessPoint = accessPoint, searchParams = searchParams );
	}
}
