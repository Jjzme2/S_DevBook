component
name="BaseLog"
hint="A Base log object for all messages on the Server."
accessors="true"
{
	property
		name="message"
		type="string";

	property
		name="level"
		type="string";

	property
		name="timestamp"
		type="string";

	property
		name="source"
		type="string";

	public BaseLog function init (message, level, source)
	{
		setMessage(arguments.message);
		setLevel(arguments.level);
		setSource(arguments.source);
		setTimestamp(Now());
		return this;
	}
}
