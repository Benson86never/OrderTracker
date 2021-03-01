component persistent="true" hint="Supplier Manager" displayname="Supplier" output="False"    {

	property name="id" column="SupplierID" fieldtype="id" generator="native";
	property name="name" column="Name" ormtype="string";
	property name="address1" column="Address1" ormtype="string"; 
	property name="address2" column="Address2" ormtype="string"; 
	property name="city" column="City" ormtype="string";
	property name="state" column="State" ormtype="string";
	property name="zip" column="Zip" ormtype="string";
	property name="country" column="Country" ormtype="string";
	property name="item" type="array" fieldtype="one-to-many" cfc="item" linktable="JoinSupplierToItem"; 
	property name="person" type="array" fieldtype="one-to-many" cfc="person" linktable="JoinSupplierToPerson"; 
	//property name="order" fieldtype="one-to-one" cfc="orders" mappedby="supplier";

}