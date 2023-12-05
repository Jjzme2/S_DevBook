component
name="message"
hint="A simple message with a type and a text"
type="object"
accessors=true
{

	property
		name="type"
		type="string"
		hint="The type of the message"
		required="false"
		default="info";
	property
		name="text"
		type="string"
		hint="The text of the message"
		required="true";
	property
		name="timestamp"
		type="datetime"
		hint="The timestamp of the message";

	public Message function init (text, type) {
		setText(arguments.text);
		setType(arguments.type ?: "info");
		setTimestamp(now());
		return this;
	}

	public struct function read() {
		return {
			type: getType(),
			text: getText(),
			timestamp: getTimestamp()
		};
	}
}