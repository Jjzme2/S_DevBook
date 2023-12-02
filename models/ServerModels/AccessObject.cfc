/**
 * A Response object from the server.
 */
component accessors="true" {

	/**
	 * --------------------------------------------------------------------------
	 * Properties
	 * --------------------------------------------------------------------------
	 */
	property name="data" 		type="any";
	property name="errors" 		type="any";
	property name="messages" 	type="array";

	// !Consider adding other info like below:

	// property name="requestType" type="string";

	/**
	 * Constructor
	 */
	function init(){
		setMessages( [] );
		setData( nullValue() );
		setErrors( {} );
		return this;
	}

	/**
	 * --------------------------------------------------------------------------
	 * Getters and Setters
	 * --------------------------------------------------------------------------
	 */

	function addMessage( required string message ) {
		arrayAppend( getMessages(), message );
		return this;
	}

	function addError( required any error ) {
		arrayAppend( getErrors(), error );
		return this;
	}
}
