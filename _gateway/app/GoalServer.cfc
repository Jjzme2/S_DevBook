/**
 * @Author Jj Zettler
 * @Description This will be the service that will handle all the related functions for this named object.
 * @date 9/21/2023
 * @version 0.1
 * @Find = Goal
 */
component singleton
	accessors="true"
	name="GoalServer"
	extends="BaseServer"
{

	property name="accessPoint" inject="GoalAccess";

	/**
	* ----------------------------------------------------------------------------------------------
    * *OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/

	/** Private functions for this service. */


	/** Common functions for this service. */

	/**
	 * This will get an empty GoalDTO.
	 * @return An empty Goal DTO.
	 */
	public GoalDTO function getEmpty()
	{
		return new models.DTO.GoalDTO();
	}

// !Old Functions
// 	public function list(){
// 		return getAll( accessPoint = accessPoint, orderedBy={'column': 'name', 'direction': 'asc'} ); // Doesn't seem to order'
// 	}

// // Searches

// 	public function getById(required string value)
// 	{
// 		var searchParams = {
// 			searchTerm  : "id"
// 			,sqlType 	: "cf_sql_varchar"
// 			,searchValue: value
// 		};

// 		var task =
// 		populator.populateFromStruct(
// 			target = getEmpty(),
// 			memento = read(accessPoint = accessPoint, searchParams = searchParams).contents
// 		)

// 		return task;

// 		// return read( accessPoint = accessPoint, searchParams = searchParams );
// 	}

// 	public function getByName(required string value)
// 	{
// 		var searchParams = {
// 			searchTerm  : "name"
// 			,sqlType 	: "cf_sql_varchar"
// 			,searchValue: value
// 		};

// 		var task =
// 		populator.populateFromQuery(
// 			target = getEmpty(),
// 			qry = read(accessPoint = accessPoint, searchParams = searchParams).contents
// 		)

// 		return task;

// 		// return read( accessPoint = accessPoint, searchParams = searchParams );
// 	}



// 	public function getByCreatedDate(required date value)
// 	{
// 		var searchParams = {
// 			searchTerm  : "creationDate"
// 			,sqlType 	: "cf_sql_datetime"
// 			,searchValue: value
// 			,relationship: "on"
// 		};
// 		var task =
// 		populator.populateFromQuery(
// 			target = getEmpty(),
// 			qry = readByDate(accessPoint = accessPoint, searchParams = searchParams).contents
// 		)

// 		return task;

// 		// return readByDate( accessPoint = accessPoint, searchParams = searchParams );
// 	}

// 	public function getByModifiedDate(required date value)
// 	{
// 		var searchParams = {
// 			searchTerm  : "recentChangeDate"
// 			,sqlType 	: "cf_sql_datetime"
// 			,searchValue: value
// 			,relationship: "on"
// 		};

// 		var entities = returnObjects(
// 			accessPoint=accessPoint
// 			,searchParams=searchParams
// 			,emptyEntity=getEmpty()
// 		);

// 		return entities;

// 		// return readByDate( accessPoint = accessPoint, searchParams = searchParams );
// 	}
}
