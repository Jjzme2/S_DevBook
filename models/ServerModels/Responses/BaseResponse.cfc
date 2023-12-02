component
name="BaseResponse"
hint="A Base response object for all responses on the Server."
accessors="true"
{

    // Properties
    property name="createdOn" type="dateTime";
    property name="messages"  type="Array";
	property name="caller"    type="string";

	// Constructor
	function init(string caller="Unknown") {
		setCreatedOn( now() );
		setMessages([]);
		setCaller(caller);
		return this;
	}


	/**
	 * --------------------------------------------------------------
	 * 						*Getters
	 * --------------------------------------------------------------
	 */

    /**
     * Get the raw messages without any modifications.
     *
     * @return array
     */
    public array function getCleanedMessages() {
        return clearUndesirableMessages();
    }

    /**
	 * --------------------------------------------------------------
	 * 						*Setters
	 * --------------------------------------------------------------
	 */


    /**
     * Add a single message to the response.
     *
     * @param message The message to add.
     * @return BaseResponse
     */
    BaseResponse function addMessage(required string message) {
        arrayAppend(this.messages, message);
        return this;
    }

    /**
     * Add an array of messages to the response.
     *
     * @param messages The messages to add.
     * @return BaseResponse
     */
    BaseResponse function addMessages(required array messages) {
        for (var message in this.messages) {
            addMessage(message);
        }
        return this;
    }

    /**
     * Clear all messages from the response.
     *
     * @return BaseResponse
     */
    BaseResponse function clearMessages() {
        this.messages = [];
        return this;
    }

    /**
	 * --------------------------------------------------------------
	 * 						*Helpers
	 * --------------------------------------------------------------
	 */

    /**
     * Remove duplicate and empty messages.
     *
     * @return array
     */
    private array function clearUndesirableMessages() {
        var desirableMessages = [];
		var unalteredMessages = this.messages;

		for (var message in unalteredMessages) {
			// Check for empty messages
			if (Trim(message) == ""){
				continue;
			}else{
				arrayAppend(desirableMessages, Trim(message));
			}

			// Check for duplicate messages
			if(arrayContains(unalteredMessages, message)){
				continue;
			}else{
				arrayAppend(desirableMessages, message);
			}

		}

        return desirableMessages;
    }
}
