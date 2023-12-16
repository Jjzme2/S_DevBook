/**
 * A Goal Object
 */
component accessors="true" {

	/**
	 * --------------------------------------------------------------------------
	 * Properties
	 * --------------------------------------------------------------------------
	 */
	// Common
	property name="id" 			type="string" 	primarykey="true";
	property name="createdOn" 	type="datetime";
	property name="modifiedOn"  type="datetime";
	property name="active" 		type="boolean";
	property name="name" 		type="string";
	property name="description" type="string";
	//Unique
	property name="status" 		type="string";
	property name="statusId" 	type="string";
	property name="notes" 		type="string";
	property name="dueDate" 	type="date";
	property name="tasks" 		type="string";
	property name="tags" 		type="string";
	property name="motivation" 	type="string";
	property name="motivationId" type="string";

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
		description:	{ required : true, type : "string"},
		status:			{ required : true, type : "string"},
		statusId:		{ required : true, type : "string"},
		notes:			{ required : true, type : "string"},
		dueDate:		{ required : true, type : "date"},
		tasks:			{ required : true, type : "string"},
		tags:			{ required : true, type : "string"},
		motivation:		{ required : true, type : "string"},
		motivationId:	{ required : true, type : "string"}

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
			"status",
			"statusId",
			"notes",
			"dueDate",
			"tasks",
			"tags",
			"motivation",
			"motivationId"
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
		setDescription("A new Goal");
		setStatus("");
		setStatusId("5853ec77-19d3-47f7-8acc-25189220c5a7")
		setNotes("");
		setDueDate(Now());
		setTasks("");
		setTags("");
		setMotivation("");
		setMotivationId("c0583364-fe4c-45a3-943f-27cb40a0cb20");
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
			'status':		getStatus(),
			'statusId':		getStatusId(), // '5853ec77-19d3-47f7-8acc-25189220c5a7
			'notes':		getNotes(),
			'dueDate':		getDueDate(),
			'tasks':		getTasks(),
			'tags':			getTags(),
			'motivation':	getMotivation(),
			'motivationId':	getMotivationId() // 'c0583364-fe4c-45a3-943f-27cb40a0cb20'
		};
	}

	function set (required struct data) {
		var properties = getProperties();
		for (property in properties) {
			if (structKeyExists(data, property)) {
				this["set" & property](data[property]);
			}
		}
		return this;
	}

	string function getJSON() {
		return serializeJSON(read());
	}

	array function getNoteArray() {
		var notes = deserializeJSON( getNotes() );
		return notes;
	}

	array function getProperties() {
		return [
			'id',
			'createdOn',
			'modifiedOn',
			'active',
			'name',
			'description',
			'status',
			'statusId',
			'notes',
			'dueDate',
			'tasks',
			'tags',
			'motivation',
			'motivationId'
		];
	}

	// string function getCSV() {
	// 	return getID() & "," &
	// 		getCreatedOn() & "," &
	// 		getModifiedOn() & "," &
	// 		getActive() & "," &
	// 		getName() & "," &
	// 		getDescription() & "," &
	// 		getStatus() & "," &
	// 		"'notes': '#getNoteArray()#'" & "," &
	// 		getDueDate() & "," &
	// 		getTasks() & "," &
	// 		getTags() & "," &
	// 		getMotivation();
	// }



	// string function getMarkdown() {
	// 	var md = "";
	// 	var encodingService = createObject( 'component', 'services.utilities.EncodingService')
	// 	// writeDump(var=encodingService, abort=true);
	// 	var hashChar = encodingService.getASCIIEncoding('numbersign');
	// 	var newLineChar = encodingService.getASCIIEncoding('carriagereturn');

	// 	md &= hashChar & hashChar & " Goal" & newLineChar;
	// 	md &= hashChar & hashChar & getName() & newLineChar;

	// 	md &= hashChar & hashChar & " Description" & newLineChar;
	// 	md &= getDescription() & newLineChar;

	// 	md &= hashChar & hashChar & " Status" & newLineChar;
	// 	md &= getStatus() & newLineChar;

	// 	md &= hashChar & hashChar & " Notes" & newLineChar;
	// 	for( note in getNoteArray() ){
	// 		md &= hashChar & hashChar & hashChar & "- " & note & newLineChar;
	// 	}


	// 	return md;

	// }


}
