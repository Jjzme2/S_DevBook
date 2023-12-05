/**
 * @Author Jj Zettler
 * @Description This will be the access point for the Task table.
 * @date 9/21/2023
 * @version 0.1
 * @FindOBJECT Task
 * @FindCOLUMNS t.id
 * ,t.created_on
 * ,t.modified_on
 * ,t.active
 * ,t.name
 * ,t.description
 * ,t.status_id
 * ,t.notes
 */

// cfformat-ignore-start
<cfcomponent output="false" extends="BaseAccess">

	<cfset tableName  = "tasks">


	<!---
	 * -------------------------------------------------------------
	 * 					*Object Retrieval
	 * -------------------------------------------------------------
	 --->

	<cffunction
		name="getByActivityStatus"
		access="package"
		returntype="QueryHandler"
		output="false"
		hint="Gets an entity by the activity status provided"
	>

		<cfargument name="status" type="boolean" required="true">

		<cftry>
			<!--- Use the private helper method to get the data we will need --->
			<cfset var qry = get(
 				searchTerm="active"
				,sqlType="cf_sql_bit"
				,searchValue="#arguments.status#"
				,exactMatch=true
				,showInactive=!arguments.status
				)>
		<cfcatch type="any">

			<cfset var messages = ["Task Access GETBYACTIVITYSTATUS", cfcatch.message]>

			<cfthrow type="CustomError" message=#serializeJSON(messages)#>
		</cfcatch>
		</cftry>

		<cfreturn new QueryHandler( qry )>
	</cffunction>



	<!---
	 * -------------------------------------------------------------
	 * 					*Object Creation/Edition
	 * -------------------------------------------------------------
	 --->

	<cffunction name="create" access="package" returntype="boolean" output="false" hint="Adds a new entry into the database.">
		<cfargument name="entity" type="TaskDTO" required="true">

		<cftry>
			<cfquery datasource=#dataSource#>
				INSERT INTO #tableName# (t.id
				,t.active
				,t.name
				,t.description
				,t.notes
				)
				VALUES (
					<cfqueryparam  value="#entity.getId()#"          cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getActive()#"      cfsqltype="cf_sql_bit">
					,<cfqueryparam value="#entity.getName()#"        cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getDescription()#" cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getNotes()#"       cfsqltype="cf_sql_varchar">
				)
			</cfquery>

			<cfcatch type="any">
				<cfset var message = {
					"customMessage": "Error occurred in Task Access CREATE.",
					"errorMessage": "#cfcatch.message#" }>
				<cfthrow type="CustomError" message=#serializeJSON(message)#>
				<cfreturn false>
			</cfcatch>
		</cftry>

		<cfreturn true>
	</cffunction>

	<cffunction name="updateById" access="package" returntype="boolean" output="false" hint="Updates an entry based on the id provided and the new Content">
		<cfargument name="currentId"type="string" required="true">
		<cfargument name="entity" 	type="struct" required="true">

		<cftry>
			<cfquery datasource=#dataSource#>
				UPDATE #tableName# t
				SET
					t.id = <cfqueryparam  value="#entity.getId()#"  cfsqltype="cf_sql_varchar">
					,t.active = <cfqueryparam value="#entity.getActive()#" cfsqltype="cf_sql_bit">
					,t.name = <cfqueryparam value="#entity.getName()#" cfsqltype="cf_sql_varchar">
					,t.description = <cfqueryparam value="#entity.getDescription()#" cfsqltype="cf_sql_varchar">
					,t.notes = <cfqueryparam value="#entity.getNotes()#" cfsqltype="cf_sql_varchar">

				WHERE t.id       = <cfqueryparam value="#currentId#" 			 cfsqltype="cf_sql_varchar">
			</cfquery>

			<cfcatch type="any">
				<cfset var message = {
					"customMessage": "Error occurred in Task Access UPDATE.",
					"errorMessage": "#cfcatch.message#" }>

				<cfthrow type="CustomError" message=#serializeJSON(message)#>

			</cfcatch>
		</cftry>

		<cfreturn true>
	</cffunction>

	/**
	 * -------------------------------------------------------------
	 * 							*Private Helpers
	 * -------------------------------------------------------------
	 */

	 <cffunction name="get" access="private" returntype="any" output="false" hint="Gets an entity by the key-value pairs provided">

		<cfargument name="searchValue" type="string"  required="true">
		<cfargument name="searchTerm"  type="string"  required="false" default="id">
		<cfargument name="sqlType"     type="string"  required="false" default="cf_sql_varchar">
		<cfargument name="exactMatch"  type="boolean" required="false" default="true">
		<cfargument name="showInactive"type="boolean" required="false" default="false">


		<cfset searchTerm = 't.' & arguments.searchTerm>

		<cftry>
			<cfquery name="qry" datasource="#dataSource#">
				SELECT t.id
				,t.created_on as createdOn
				,t.modified_on as modifiedOn
				,t.active
				,t.name
				,t.description
				,t.status_id as statusId
				,s.name as status
				,t.notes

				FROM #tableName# t
				LEFT JOIN statuses s ON t.status_id = s.id

				<cfif arguments.exactMatch>
					WHERE #searchTerm# = <cfqueryparam value="#searchValue#" cfsqltype="#sqlType#">
						<cfif arguments.searchTerm NEQ 'active'>
							AND t.active = <cfqueryparam value="#!arguments.showInactive#" cfsqltype="cf_sql_bit">
						</cfif>
				<cfelse>
					WHERE #searchTerm# LIKE <cfqueryparam value="%#searchValue#%" cfsqltype="#sqlType#">
					<cfif arguments.searchTerm NEQ 'active'>
						AND t.active = <cfqueryparam value="#!arguments.showInactive#" cfsqltype="cf_sql_bit">
					</cfif>
				</cfif>
			</cfquery>

			<cfcatch type="any">
				<cfset var message = {
					"customMessage": "Error occurred in Task Access GET.",
					"errorMessage": "#cfcatch.message#" }>

				<cfthrow type="CustomError" message=#serializeJSON(message)#>

			</cfcatch>
		</cftry>


		<cfreturn qry>
	</cffunction>



</cfcomponent>
// cfformat-ignore-end

