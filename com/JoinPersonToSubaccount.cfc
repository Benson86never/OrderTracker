component persistent="true" {
	property name="id" column="ID" fieldtype="id" generator="native";
	property name="personid" column="PersonID" ormtype="int";
	property name="subaccountid" column="SubAccountID" ormtype="int";	
	//property name="subaccount" fieldtype="one-to-one" cfc="subaccount" fkcolumn="SubAccountID" type="array";
	property name="subaccount" fieldtype="one-to-one" cfc="subaccount" fkcolumn="subaccountid";
	}