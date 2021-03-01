component persistent="true" {
	property name="id" type="numeric" ormtype="int" fieldtype="id"  generator="native"; 
	property name="itemid" column="ItemID" ormtype="int";
	property name="cartid" column="CartID" ormtype="int";
	property name="supplierid" column="SupplierID" ormtype="int";
	property name="quantity" column="CartQuantity" ormtype="int";
	property name="supplier" fieldtype="one-to-many" cfc="supplier" fkcolumn="SupplierID" type="array" orderby="SupplierID" ;
	
	}