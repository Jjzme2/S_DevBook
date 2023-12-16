/**
 * @Author Jj Zettler
 * @Description This will be the server that will handle all the related functions for the Status objects.
 * @date 12/9/2023
 * @version 0.1
 * @Find = Status
 */
component singleton
	accessors="true"
	name="StatusServer"
	extends="BaseServer"
{

	property name="accessPoint" inject="StatusAccess";

	/**
	* ----------------------------------------------------------------------------------------------
    * *OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/

	/** Private functions for this service. */


	/** Common functions for this service. */

	/**
	 * This will get an empty StatusDTO.
	 * @return An empty Status DTO.
	 */
	public StatusDTO function getEmpty()
	{
		return new models.DTO.StatusDTO();
	}
}