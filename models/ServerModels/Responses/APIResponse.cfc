component
	name="ApiResponse"
	extends="BaseResponse"
	hint="A API response object."
	accessors="true"
{
	property
		name="data"
		type="any"
		default=""
		hint="The data to send, if any";


	ApiResponse function init(
		string caller="ApiResponse"
		,any data=[]
		,array messages=[]
		)
	{
		super.init( arguments.caller );

		checkData(data);

		setMessages( arguments.messages );
		setData( arguments.data );
		return this;
	}

	private boolean function checkData( any data )
	{
		if( !isNull( arguments.data ) && !isSimpleValue( arguments.data ) && !isArray( arguments.data ) && !isStruct( arguments.data ) )
		{
			throw( type="InvalidData", message="The data argument must be a simple value, array, or struct." );
		}
		return true;
	}
}

