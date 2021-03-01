component persistent="true" displayname="Master Account" hint="Manages Master accounts" {
	property name="id" column="MasterID" fieldtype="id" generator="increment";
	property name="name" column="Name" ormtype="string";
	property name="subaccount" type="array" fieldtype="one-to-many" cfc="subaccount" linktable="JoinMasterAccountToSubAccount"; 
	property name="item" type="array" fieldtype="one-to-many" cfc="item" linktable="JoinMasterAccountToItem"; 
	property name="supplier" type="array" fieldtype="one-to-many" cfc="supplier" linktable="JoinMasterAccountToSupplier";
}

