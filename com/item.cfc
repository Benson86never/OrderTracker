component persistent="true" {

	property name="id" column="ItemID" fieldtype="id" generator="native";
	property name="name" column="Name" ormtype="string";
	property name="photourl" column="PhotoURL" ormtype="string"; 
	property name="sku" column="SKU" ormtype="string"; 	
	//property name="units" fieldtype="one-to-one" cfc="units" fetch="join";
	//property name="units" fieldtype="many-to-one" cfc="units" fkcolumn="UnitID" fetch="join" ;
	property name="supplier" type="array" fieldtype="one-to-many" cfc="supplier" linktable="JoinSupplierToItem";
	property name="units" fieldtype="one-to-one" cfc="units" fkcolumn="UnitID";
	
	}