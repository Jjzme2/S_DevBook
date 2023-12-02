component
name="BaseAccessor"
hint="A Base accessor object for all Gateway objects."
accessors="true"
{

    // Properties
    property name="createdOn" type="dateTime";
	property name="caller"    type="string";
	property name="qry"       type="query";

	// Constructor
	function init(string caller="Unknown") {
		setCreatedOn( now() );
		setCaller( caller );
		setQry( queryNew(columnList="" ) );
		return this;
	}


	/**
	 * --------------------------------------------------------------
	 * 						*Getters
	 * --------------------------------------------------------------
	 */


}
