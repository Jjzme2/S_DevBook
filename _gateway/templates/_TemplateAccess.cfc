/**
 * @Author Jj Zettler
 * @Description This will be the access point for the OBJECTNAME table.
 * @date 9/21/2023
 * @version 0.1
 * @FindOBJECT OBJECTNAME
 * @FindCOLUMNS COLS
 */

// cfformat-ignore-start
<cfcomponent output="false" extends="BaseAccess">

	<cfset tableName  = "OBJECTNAMEs"> <!--- ?Lowercase and plural this, following whatever is in the database. --->
	<cfset dataSource = ""> 	<!--- !SET THIS If not using primary datasource. --->

	<!---
	 * -------------------------------------------------------------
	 * 	CRUD FUNCTIONS -- In General, these will be the content from the database directly, as that is what we will be
	 *  create or updating.
	 * -------------------------------------------------------------
	 --->

	<cffunction name="create" access="package" returntype="boolean" output="false" hint="Adds a new entry into the database.">
		<cfargument name="entity" type="OBJECTNAMEDTO" required="true">

		<cftry>
			<cfquery datasource=#dataSource#>
				INSERT INTO #tableName# (COLS)
				VALUES (
					<cfqueryparam  value="#entity.getId()#"  cfsqltype="cf_sql_varchar"> <!--- !SET THIS --->
				)
			</cfquery>

			<cfcatch type="any">
				<cfset var message = {
					"customMessage": "Error occurred in OBJECTNAME Access CREATE.",
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
					t.id = <cfqueryparam  value="#entity.getId()#"  cfsqltype="cf_sql_varchar"> <!--- *Example --->

				WHERE t.id       = <cfqueryparam value="#currentId#" 			 cfsqltype="cf_sql_varchar">
			</cfquery>

			<cfcatch type="any">
				<cfset var message = {
					"customMessage": "Error occurred in OBJECTNAME Access UPDATE.",
					"errorMessage": "#cfcatch.message#" }>

				<cfthrow type="CustomError" message=#serializeJSON(message)#>

			</cfcatch>
		</cftry>

		<cfreturn true>
	</cffunction>


	<!---
	 * -------------------------------------------------------------
	 * 	GETTERS -- These will generally be the content that we want rendered, so it might include joins or other logic.
	 * -------------------------------------------------------------
	 --->

	<cffunction name="get" access="package" returntype="any" output="false" hint="Gets an entity by the key-value pairs provided">

		<cfargument name="searchValue" type="string"  required="true">
		<cfargument name="searchTerm"  type="string"  required="false" default="id">
		<cfargument name="sqlType"     type="string"  required="false" default="cf_sql_varchar">
		<cfargument name="exactMatch"  type="boolean" required="false" default="true">
		<cfargument name="showInactive"type="boolean" required="false" default="false">


		<cfset searchTerm = 't.' & arguments.searchTerm>

		<cftry>
			<cfquery name="get" datasource="#dataSource#">
				SELECT COLS
				FROM #tableName# t
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
					"customMessage": "Error occurred in OBJECTNAME Access GET.",
					"errorMessage": "#cfcatch.message#" }>

				<cfthrow type="CustomError" message=#serializeJSON(message)#>

			</cfcatch>
		</cftry>

		<cfreturn get>
	</cffunction>

	<cffunction
		name      ="getByCreationDate"
		access    ="package"
		returntype="query"
		output    ="false"
		hint      ="Gets an entity by the creation date provided"
	>
		<cfargument name="searchTerm" type="string" required="false" default="created_on">
		<cfargument name="sqlType" type="string" required="false" default="cf_sql_timestamp">
		<cfargument name="searchValue" type="string" required="false" default="">
		<cfargument name="showInactive" type="boolean" required="false" default="false">
		<cfargument
			name    ="relationship"
			type    ="string"
			required="false"
			default ="on"
			hint    ="on|onOrBefore|onOrAfter|after|before"
		>

		<cfset searchTerm = "t." & arguments.searchTerm>

		<cftry>
			<cfquery name="getByCreationDate" datasource="#dataSource#">
				SELECT COLS

				FROM #tableName# t

				<cfswitch expression=#arguments.relationship#>
					<cfcase value="on">
					WHERE #searchTerm# = <cfqueryparam value="#searchValue#" cfsqltype="#sqlType#">
						<cfif arguments.searchTerm NEQ "active">
							AND t.active = <cfqueryparam value="#!arguments.showInactive#" cfsqltype="cf_sql_bit">
						</cfif>
					</cfcase>

					<cfcase value="onOrBefore">
					WHERE #searchTerm# <= <cfqueryparam value="#searchValue#" cfsqltype="#sqlType#">
						<cfif arguments.searchTerm NEQ "active">
							AND t.active = <cfqueryparam value="#!arguments.showInactive#" cfsqltype="cf_sql_bit">
						</cfif>
					</cfcase>

					<cfcase value="onOrAfter">
					WHERE #searchTerm# >= <cfqueryparam value="#searchValue#" cfsqltype="#sqlType#">
						<cfif arguments.searchTerm NEQ "active">
							AND t.active = <cfqueryparam value="#!arguments.showInactive#" cfsqltype="cf_sql_bit">
						</cfif>
					</cfcase>

					<cfcase value="after">
					WHERE #searchTerm# > <cfqueryparam value="#searchValue#" cfsqltype="#sqlType#">
						<cfif arguments.searchTerm NEQ "active">
							AND t.active = <cfqueryparam value="#!arguments.showInactive#" cfsqltype="cf_sql_bit">
						</cfif>
					</cfcase>

					<cfcase value="before">
					WHERE #searchTerm# < <cfqueryparam value="#searchValue#" cfsqltype="#sqlType#">
						<cfif arguments.searchTerm NEQ "active">
							AND t.active = <cfqueryparam value="#!arguments.showInactive#" cfsqltype="cf_sql_bit">
						</cfif>
					</cfcase>

					<cfdefaultcase>
					WHERE #searchTerm# = <cfqueryparam value="#searchValue#" cfsqltype="#sqlType#">
						<cfif arguments.searchTerm NEQ "active">
							AND t.active = <cfqueryparam value="#!arguments.showInactive#" cfsqltype="cf_sql_bit">
						</cfif>
					</cfdefaultcase>
				</cfswitch>
			</cfquery>
			<cfcatch type="any">
				<cfset var message = {
					"customMessage" : "Error occurred in OBJECTNAME Access GETBYCREATIONDATE.",
					"errorMessage"  : "#cfcatch.message#"
				}>

				<cfthrow type="CustomError" message=#serializeJSON( message )#>
			</cfcatch>
		</cftry>

		<cfreturn getByCreationDate>
	</cffunction>
</cfcomponent>
// cfformat-ignore-end

