/**
 * @Author      Jj Zettler
 * @Description This serves as the base access point for the OBJECTNAME table.
 * @date        9/21/2023
 * @version     0.1
 * @FindOBJECT  OBJECTNAME
 * @FindCOLUMNS COLS
 */

<!--- The comment below, as is (?) will ignore this file until it finds the comment at the bottom of this document.   --->
// cfformat-ignore-start

<cfcomponent output = 'false'>

	/* Properties for tableName and dataSource */
	<cfset tableName  = ''> /* Defined in the extending component */
	<cfset dataSource = application.cbController.getSetting( 'primaryDatasource' )>
	<cfset converter  = createObject( 'services.utilities.ConversionService' )>
	<cfset objectUtil = createObject( 'services.utilities.ObjectService' )>

	/*
	 * ---------------------------------------------------
	 * Common CRUD Functions
	 * ---------------------------------------------------
	 */

	/* List all rows within the specified table */
	<cffunction name='list'
		access='package'
		returntype='Array'
		output='false'
		hint='Returns all rows within the specified table.'>

		<cfargument name='order' type='struct' required='false' default='#{}#'>

		<cftry>
			<cfquery name='queryResult' datasource='#variables.dataSource#'>
				SELECT *
				FROM #variables.tableName# t
				<cfif structKeyExists(arguments.order, 'column')>
					ORDER BY t.#arguments.order.column# #arguments.order.direction#
				</cfif>
			</cfquery>

			<cfset var result = lowerCaseColumns(query=queryResult)>

			<cfcatch type='CustomError'>
				<cfset var errorMessage = {
					'customMessage': 'Error occurred in LIST.',
					'errorMessage': 'Custom error message here'
				}>
				<cfthrow type='CustomError' message='#SerializeJSON(errorMessage)#'>
			</cfcatch>
		</cftry>

		<cfreturn result>
	</cffunction>



	/* Set the active status of an entry in the database */
	<cffunction name = 'setActive'
		access = 'package'
		output = 'false'
		hint   = 'Sets the active status of an entry in the database'>

		<cfargument name = 'entityId' type = 'string' required = 'true'>
		<cfargument name = 'active' type = 'boolean' required = 'true'>

		<cftry>
			<cfquery datasource = '#variables.dataSource#'>
				UPDATE #variables.tableName# t
				SET t.active =  <cfqueryparam value = '#arguments.active#' cfsqltype = 'cf_sql_bit'>
				WHERE t.id   =  <cfqueryparam value = '#arguments.entityId#' cfsqltype = 'cf_sql_varchar'>
			</cfquery>
			<cfcatch type = 'any'>
				<cfset var errorMessage = {
					'customMessage': 'Error occurred in SETACTIVE.'
					,'errorMessage' : '#cfcatch.message#'
				}>
				<cfthrow type = 'CustomError' message = '#SerializeJSON( errorMessage )#'>
			</cfcatch>
		</cftry>
	</cffunction>


	/* Delete an entry in the database, be careful when using this, generally deactivate is preferred */
	<cffunction name = 'deleteById'
		access = 'package'
		output = 'false'
		hint   = 'Deletes an entry in the database, be careful when using this, generally deactivate is preferred.'>

		<cfargument name = 'entityId' type = 'string' required = 'true'>
		<cftry>
			<cfquery datasource = '#variables.dataSource#'>
				DELETE FROM #variables.tableName# t
				WHERE t.id =  <cfqueryparam value = '#arguments.entityId#' cfsqltype = 'cf_sql_varchar'>
			</cfquery>
			<cfcatch type = 'any'>
				<cfset var errorMessage = {
					'customMessage': 'Error occurred in DELETEBYID.'
					,'errorMessage' : '#cfcatch.message#'
				}>
				<cfthrow type = 'CustomError' message = '#SerializeJSON( errorMessage )#'>
			</cfcatch>
		</cftry>
	</cffunction>


	/* Cycles each column in the query and converts it to lowercase */
	<cffunction name = 'lowerCaseColumns'
		access = 'private'
		output = 'false'
		hint   = 'Cycles each column in the query and converts it to lowercase'>

		<cfargument name = 'query' type = 'query' required = 'true'>

		<cftry>
		<cfset lowercaseResults = []>
			<cfloop query=#arguments.query#>
				<cfset lowercaseRow = {}>
				<cfloop list='#queryColumnList(arguments.query)#' index='column'>
					<cfset lowercaseRow[column] = lCase(arguments.query[column])>
				</cfloop>
				<cfset arrayAppend(lowercaseResults, lowercaseRow)>
			</cfloop>

			<cfcatch>
				<cfset var errorMessage = {
					'customMessage': 'Error occurred in LOWERCASECOLUMNS.'
					,'errorMessage' : '#cfcatch.message#'
				}>
				<cfthrow type = 'CustomError' message = '#SerializeJSON( errorMessage )#'>
			</cfcatch>
		</cftry>

		<cfreturn lowercaseResults>
	</cffunction>


	<cffunction name="serializeJSONArray" access="public" returntype="void" hint="Convert the JSON array(fieldName) in (data)">
		<cfargument name="data" required="true">
		<cfargument name="fieldName" required="true">

		/** Example JSON: {
			Path: '"/_common/examples/json_examples/jsonCommon.json"
			,id="b48cfcb0-80be-11ee-b962-0242ac120002"'
		}
		**/
		<cftry>
			<cfloop query="#data#">
				<cfset data[fieldName][currentRow] = deserializeJSON(data[fieldName][currentRow])>
			</cfloop>
		<cfcatch>
			<cfset var errorMessage = {
				'customMessage': 'Error occurred in SERIALIZEFIELD.'
				,'errorMessage' : '#cfcatch.message#'
			}>
			<cfthrow type = 'CustomError' message = '#SerializeJSON( errorMessage )#'>
		</cfcatch>
		</cftry>
	</cffunction>
</cfcomponent>

<!---  This is the comment that will end the cfformat --->
// cfformat-ignore-end

