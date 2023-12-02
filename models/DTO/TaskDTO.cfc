/**
 * A Game model Object used to pass around information
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
	property name="statusId" 	type="string";
	property name="status" 		type="string";
	property name="notes" 		type="struct";

	/**
	 * --------------------------------------------------------------------------
	 * Mementifier
	 * --------------------------------------------------------------------------
	 */
	this.memento = {
		defaultIncludes : [ "*" ],
		defaultExcludes : [ "statusId" ],
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
		statusId:		{ required : true, type : "string"},
		status:			{ required : true, type : "string"},
		notes:			{ required : true, type : "struct"}
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
			"statusId",
			"status",
			"notes"
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
		setStatusId("");
		setStatus("");
		setNotes({});
		return this;
	}

	/**
	 * --------------------------------------------------------------------------
	 * Getters and Setters
	 * --------------------------------------------------------------------------
	 */

	function read() {

		// Loop each item in notes, if the string is empty, remove it.
		var notes = getNotes().notes;
		arrayMap(notes, (note) => {
			if(trim(note) EQ "") {
				arrayDelete(notes, note);
			}
		});

		return {
			'id':			getId(),
			'createdOn':	getCreatedOn(),
			'modifiedOn':	getModifiedOn(),
			'active':		getActive(),
			'name':			getName(),
			'description':	getDescription(),
			'statusId':		getStatusId(),
			'status':		getStatus(),
			'notes':		notes
		};
	}

}
