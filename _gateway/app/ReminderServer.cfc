/**
 * @Author Jj Zettler
 * @Description This will be the service that will handle all the related functions for this named object.
 * @date 9/21/2023
 * @version 0.1
 * @Find = Reminder
 */
component singleton
	accessors="true"
	name="ReminderServer"
	extends="BaseServer"
{

	property name="accessPoint" inject="ReminderAccess";

	/**
	* ----------------------------------------------------------------------------------------------
    * *OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/

	/** Private functions for this service. */


	/** Common functions for this service. */

	/**
	 * This will get an empty ReminderDTO.
	 * @return An empty Reminder DTO.
	 */
	public ReminderDTO function getEmpty()
	{
		return new models.DTO.ReminderDTO();
	}
}