component
name="ObjectService"
hint="A service that allows you to manipulate objects from wirebox"
singleton
{
	public any function getWirebox(){
		try{
			return	application.wirebox;
		}catch(any e){
			throw("Wirebox is not available in this context");
		}
	}

	public function getObject(required string wireboxName) {
		try{
			return getWirebox().getInstance(arguments.wireboxName);
		}catch(any e){
			var message = {
				'Custom Message': 'Object not found in Wirebox: {' & arguments.wireboxName & '} Please make sure you have mapped the object in `/config/Wirebox`.'
				,'Error Message': e.message
			}
			throw(serializeJSON(message));
		}
	}
}