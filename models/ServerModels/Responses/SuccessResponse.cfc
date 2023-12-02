component
name="SuccessResponse"
extends="BaseResponse"
hint="A successful response object."
accessors="true"
{
	property name="data" type="any" default="" hint="The data to send";
	property name="messages" type="array" default="" hint="The messages to send";
	property name="status" type="string" default="success" hint="The status of the response";


	SuccessResponse function init(string caller="SuccessResponse", any data="N/A", array messages=[])
	{
		super.init( arguments.caller );
		setStatus( 'Success' );
		setData( arguments.data );
		setMessages( arguments.messages );
		return this;
	}
}

