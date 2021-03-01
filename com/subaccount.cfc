component persistent="true" displayname="Sub Account" hint="Manages Master Account sub accounts" {
	
	property name="id" column="SubAccountID" fieldtype="id" generator="increment";
	property name="name" column="Name" ormtype="string";
	property name="address1" column="Address1" ormtype="string"; 
	property name="address2" column="Address2" ormtype="string"; 
	property name="city" column="City" ormtype="string";
	property name="state" column="State" ormtype="string";
	property name="zip" column="Zip" ormtype="string";
	property name="country" column="Country" ormtype="string";
	property name="list" fieldtype="one-to-many" cfc="list" fkcolumn="SubAccountID" type="array";
	property name="item" type="array" fieldtype="one-to-many" cfc="item" linktable="JoinAccountToItem"; 
	property name="masteraccount" type="array" fieldtype="one-to-many" cfc="masteraccount" linktable="JoinMasterAccountToSubAccount"; 
}