component
name="ErrorLog"
hint="An Error log object for all messages on the Server."
accessors="true"
extends="BaseLog"
{
	property
		name="error"
		type="any";

	public ErrorLog function init (message, source, error)
	{
		super.init(message=arguments.message, level='Error', source=arguments.source);
		setError(arguments.error)
		return this;
	}

	public function dump(boolean doAbort=true)
	{
		var dump = {
			"message": getMessage(),
			"level": getLevel(),
			"source": getSource(),
			"error": getError(),
		}

		writeDump(var=dump, label="#getLevel()#Log", abort=doAbort);
	}

}
