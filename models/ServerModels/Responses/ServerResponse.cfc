component
	name="ServerResponse"
	extends="BaseResponse"
	hint="A server response object."
	accessors="true"
{
	property
		name="data"
		type="any"
		default=""
		hint="The data to send";

	property
		name="server"
		type="string"
		default=""
		hint="The server that served the response";

	property
		name="success"
		type="boolean"
		default="true"
		hint="Whether the response was successful, defaults to true";

	ServerResponse function init(
		string server=""
		,string caller="ServerResponse"
		)
	{
		super.init( arguments.caller );
		setServer( arguments.server );
		addMessage( "Served by #arguments.server#" );
		return this;
	}
}