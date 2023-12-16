/**
 * A Suggestion Object
 */
component accessors="true" {

	/**
	 * --------------------------------------------------------------------------
	 * Properties
	 * --------------------------------------------------------------------------
	 */
	// CONSTANT Properties
	property name="id" 			type="string" 	primarykey="true";
	property name="createdOn" 	type="datetime";
	property name="modifiedOn"  type="datetime";
	property name="active" 		type="boolean";


	// COMMON Properties
	property name="name" 		type="string";
	property name="description" type="string";
	property name="statusID" 	type="string";
	property name="status"		type="string";


	/**
	 * --------------------------------------------------------------------------
	 * Mementifier
	 * --------------------------------------------------------------------------
	 */
	this.memento = {
		defaultIncludes : [ "*" ],
		defaultExcludes : [ "statusID" ],
		neverInclude    : []
	};

	/**
	 * --------------------------------------------------------------------------
	 * Validation
	 * --------------------------------------------------------------------------
	 */
	this.constraints = {
		id:				{ required : true, type : "string"},
		active:			{ required : true, type : "boolean"},
		name:			{ required : true, type : "string"},
		description:	{ required : true, type : "string"},
		statusID:		{ required : true, type : "string"},
		status:			{ required : true, type : "string"}
	};

	/**
	 * --------------------------------------------------------------------------
	 * Population
	 * --------------------------------------------------------------------------
	 */
	this.population = {
		include: [
			"id",
			"createdOn",
			"modifiedOn",
			"active",
			"name",
			"description",
			"statusID",
			"status"
		]
	}

	/**
	 * Constructor
	 */
	function init(){
		setId(createUUID());
		setCreatedOn(Now());
		setModifiedOn(Now());
		setActive(false);
		setName("");
		setDescription("");
		setStatusID("5853ec77-19d3-47f7-8acc-25189220c5a7"); // Default Status -- Not Started
		setStatus("Not Started");
		return this;
	}


	/**
	 * --------------------------------------------------------------------------
	 * Getters and Setters
	 * --------------------------------------------------------------------------
	 */

	function read() {

		return {
			'id':			getId(),
			'createdOn':	getCreatedOn(),
			'modifiedOn':	getModifiedOn(),
			'active':		getActive(),
			'name':			getName(),
			'description':	getDescription(),
			'statusID':		getStatusID(),
			'status':		getStatus()
		};
	}

	string function getCSV() {
		return getID() & "," &
			getCreatedOn() & "," &
			getModifiedOn() & "," &
			getActive() & "," &
			getName() & "," &
			getDescription() & "," &
			getStatusID() & "," &
			getStatus();
	}

	string function getJSON() {
		return serializeJSON(read());
	}

	array function getProperties() {
		return [
			'id',
			'createdOn',
			'modifiedOn',
			'active',
			'name',
			'description',
			'statusID',
			'status'
		];
	}
}
