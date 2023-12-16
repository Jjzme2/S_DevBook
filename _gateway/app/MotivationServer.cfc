/**
 * @Author Jj Zettler
 * @Description This will be the server that will handle all the related functions for the Motivation objects.
 * @date 12/9/2023
 * @version 0.1
 * @Find = Motivation
 */
component singleton
	accessors="true"
	name="MotivationServer"
	extends="BaseServer"
{

	property name="accessPoint" inject="MotivationAccess";

	/**
	* ----------------------------------------------------------------------------------------------
    * *OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/

	/** Private functions for this service. */


	/** Common functions for this service. */

	/**
	 * This will get an empty MotivationDTO.
	 * @return An empty Motivation DTO.
	 */
	public MotivationDTO function getEmpty()
	{
		return new models.DTO.MotivationDTO();
	}
}