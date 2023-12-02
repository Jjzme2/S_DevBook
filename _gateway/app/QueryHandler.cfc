<cfcomponent
	name="QueryHandler"
	output="false"
	hint="I handle all returned queries from the access components."
>

	<cfproperty
		name="qry"
		type="query"
	>

	<!--- Initialize the Query Handler Object  --->
	<cffunction
		name="init"
		output="false"
		returntype="QueryHandler"
		hint="I initialize the query handler."
	>
		<cfargument
			name="qry"
			type="query"
			required="true"
			hint="I am the query to be handled."
		>

		<cfset variables.qry = arguments.qry>

		<cfreturn this>

	</cffunction>


	<!--- Get the number of records in the query --->
	<cffunction
		name="getRecordCount"
		output="false"
		returntype="numeric"
		hint="I return the number of records in the query."
	>
		<cfreturn variables.qry.recordCount>
	</cffunction>

	<!--- Gets the query data as a JSON string --->
	<cffunction
		name="getJson"
		output="false"
		returntype="string"
		hint="I return the query as a JSON string."
	>
		<cfreturn variables.qry.toJson()>
	</cffunction>

	<!--- Gets the query data as a struct --->
	<cffunction
		name="getStruct"
		output="false"
		returntype="struct"
		hint="I return the query as a struct."
	>
		<cfreturn deserializeJSON(variables.qry.toJson())>
	</cffunction>

	<!--- Gets the query data as an array --->
	<cffunction
		name="getArray"
		output="false"
		returntype="array"
		hint="I return the query as an array."
	>
		<cfset var arr = []>
		<cfloop query="variables.qry">
			<cfset arrayAppend(arr, variables.qry.row)>
		</cfloop>

		<cfreturn arr>
	</cffunction>



</cfcomponent>