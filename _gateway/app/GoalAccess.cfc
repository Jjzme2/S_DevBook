/**
 * @Author Jj Zettler
 * @Description This will be the access point for the Goal table.
 * @date 9/21/2023
 * @version 0.1
 * @FindOBJECT Goal
 * @FindCOLUMNS t.id
 * ,t.created_on
 * ,t.modified_on
 * ,t.active
 * ,t.name
 * ,t.description
<!---  * ,t.status_id --->
 * ,t.notes
 */

// cfformat-ignore-start
<cfcomponent output="false" extends="BaseAccess">

	<cfset tableName  = "goals">


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
		hint="Gets a QueryHandler object with the data retrieved from the database."
	>

		<cfargument name="status" type="boolean" required="true">

		<cftry>
			<!--- Use the private helper method to get the data we will need --->
			<cfset var qry = get(
				searchTerm="active"
				<!--- searchTerm="activ" --->
				,sqlType="cf_sql_bit"
				,searchValue="#arguments.status#"
				,exactMatch=true
				,showInactive=!arguments.status
				)>
		<cfcatch type="any">

			<cfset var messages = ["Goal Access GETBYACTIVITYSTATUS", cfcatch.message]>

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

	<cffunction name="create" access="package" returntype="any" output="false" hint="Adds a new entry into the database.">
		<cfargument name="entity" type="GoalDTO" required="true">

		<cftry>
			<cfquery name="qry" datasource="#dataSource#">
				INSERT INTO #tableName# (
					id,
					active,
					name,
					description,
					status_id,
					notes,
					due_date,
					tasks,
					tags,
					motivation_id
				)
				VALUES(
					<cfqueryparam value="#entity.getId()#" cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getActive()#" cfsqltype="cf_sql_bit">
					,<cfqueryparam value="#entity.getName()#" cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getDescription()#" cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getStatusId()#" cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getNotes()#" cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getDueDate()#" cfsqltype="cf_sql_date">
					,<cfqueryparam value="#entity.getTasks()#" cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getTags()#" cfsqltype="cf_sql_varchar">
					,<cfqueryparam value="#entity.getMotivationId()#" cfsqltype="cf_sql_varchar">
				);
				</cfquery>

				<cfset var qry = get(
					searchTerm="id"
					,sqlType="cf_sql_varchar"
					,searchValue="#entity.getId()#"
					,exactMatch=true
					,showInactive=true
					)>
					<cfreturn new QueryHandler( qry )>

				<cfcatch>
					<cfset var message = {
					"customMessage": "Error occurred in Goal Access CREATE.",
					"errorMessage": "#cfcatch.message#" }>
				<cfthrow type="CustomError" message=#serializeJSON(message)#>
					<cfreturn false>
				</cfcatch>
		</cftry>
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
					"customMessage": "Error occurred in Goal Access UPDATE.",
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
				SELECT t.id,
					t.created_on AS createdOn,
					t.modified_on AS modifiedOn,
					t.active,
					t.name,
					t.description,
					s.name AS status,
					t.due_date AS dueDate,
					t.tags,
					m.name AS motivation,
					(
						SELECT
							JSON_ARRAYAGG(
								JSON_OBJECT(
									'name', n.name,
									'detail', n.description
								)
							)
						FROM notes n
						WHERE FIND_IN_SET(n.id, REPLACE(t.notes, ',', ',')) > 0
						LIMIT 1
					) AS notes,
					(
						SELECT
							JSON_ARRAYAGG(
								JSON_OBJECT(
									'name', st.name,
									'detail', st.description,
									'followUpNotes', st.follow_up_notes,
									'completed', CAST(st.is_complete AS SIGNED)
								)
							)
						FROM tasks st
						WHERE FIND_IN_SET(st.id, REPLACE(t.tasks, ',', ',')) > 0
						LIMIT 1
					) AS tasks
				FROM #tableName# t
				LEFT JOIN statuses s ON t.status_id = s.id
				LEFT JOIN motivations m ON t.motivation_id = m.id
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
				ORDER BY
					dueDate,
					status ASC,
					createdOn DESC,
					t.name;
			</cfquery>


			<cfcatch type="any">
				<cfset var message = {
					"customMessage": "Error occurred in Goal Access GET.",
					"errorMessage": "#cfcatch.message#" }>

				<cfthrow type="CustomError" message=#serializeJSON(message)#>

			</cfcatch>
		</cftry>


		<cfreturn qry>
	</cffunction>



</cfcomponent>
// cfformat-ignore-end

