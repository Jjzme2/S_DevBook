component
name="MessengerAccessor"
hint="An accessor object that will also return a message."
extends="BaseAccessor"
accessors="true"
component {

	property name="messages" type="array";

	MessengerAccessor function init(
		string caller="MessengerAccessor"
		,query returnedQuery=nullValue()
		,messages=[]
	) {
		super.init();
		setMessages( messages );
		setCaller( caller );
		setQry( returnedQuery ?: queryNew(columnList="") );
		return this;
	}

	public void function addMessage( required string message ) {
		var currentMessages = getMessages();
		arrayAppend( currentMessages, message );
		setMessages( currentMessages );
	}

	public void function addMessages( required array messages ) {
		var currentMessages = getMessages();
		for( message in messages ) {
			if( !arrayContains( currentMessages, message ) )
				arrayAppend( currentMessages, message );
		}
		setMessages( currentMessages );
	}

	public struct function read() {
		var returnArray=false;

		if( !getQry().recordCount )
			addMessage( "No records found." );
		if( getQry().recordCount > 1 ) {
			addMessage( "Multiple records found." );
			returnArray=true;
		}

		var data = {};

		if( returnArray ){
			data = [];
			queryEach(getQry(), (row) => {
				arrayAppend( data, row );
			});
		}
		else {
			data = getQry().getCurrent();
		}

		var result = structNew();
		result.messages = getMessages();
		result.data = data;
		result.caller = getCaller();
		result.timeStamp = getCreatedOn();

		return result;
	}
}