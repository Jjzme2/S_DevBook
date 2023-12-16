/**
 * @Author Jj Zettler
 * @Description This will be the server that will handle all the related functions for the Suggestion objects.
 * @date 12/9/2023
 * @version 0.1
 * @Find = Suggestion
 */
component singleton
	accessors="true"
	name="SuggestionServer"
	extends="BaseServer"
{

	property name="accessPoint" inject="SuggestionAccess";

	/**
	* ----------------------------------------------------------------------------------------------
    * *OBJECT INSTANTIATION
	* ----------------------------------------------------------------------------------------------
	*/

	/** Private functions for this service. */


	/** Common functions for this service. */

	/**
	 * This will get an empty SuggestionDTO.
	 * @return An empty Suggestion DTO.
	 */
	public SuggestionDTO function getEmpty()
	{
		return new models.DTO.SuggestionDTO();
	}
}