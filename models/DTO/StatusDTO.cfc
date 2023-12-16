/**
 * A Status Object
 */
component accessors="true" {

	/**
	 * --------------------------------------------------------------------------
	 * Properties
	 * --------------------------------------------------------------------------
	 */
	property name="id" 			type="string" 	primarykey="true";
	property name="createdOn" 	type="datetime";
	property name="modifiedOn"  type="datetime";
	property name="active" 		type="boolean";
	property name="name" 		type="string";
	property name="description" type="string";

	/**
	 * --------------------------------------------------------------------------
	 * Mementifier
	 * --------------------------------------------------------------------------
	 */
	this.memento = {
		defaultIncludes : [ "*" ],
		defaultExcludes : [ "" ],
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
		description:	{ required : true, type : "string"}
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
			"description"
		]
	}

	/**
	 * Conanyor
	 */
	function init(){
		setId(createUUID());
		setCreatedOn(Now());
		setModifiedOn(Now());
		setActive(false);
		setName("");
		setDescription("");
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
			'description':	getDescription()
		};
	}

	string function getCSV() {
		return getID() & "," &
			getCreatedOn() & "," &
			getModifiedOn() & "," &
			getActive() & "," &
			getName() & "," &
			getDescription();
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
			'description'
		];
	}
}
