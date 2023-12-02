component
name="ErrorResponse"
extends="BaseResponse"
hint="An Error response object."
accessors="true"
{
	property name="messages" type="array" default="" hint="The messages to send";
	property name="status" type="string" default="success" hint="The status of the response";
	property name="error"  type="any" default="" hint="The error to send";

	ErrorResponse function init(string caller="ErrorResponse", any error="", array messages=[])
	{
		super.init( arguments.caller );
		setMessages( arguments.messages );
		setStatus( 'Error' );
		setError( arguments.error );
		return this;
	}
}

