component persistent="true" {

	property name="id" column="CartID" fieldtype="id" generator="native";
	property name="datetime" column="DateTime" ormtype="timestamp";
	property name="subaccountid" column="SubAccountID" ormtype="int"; 
	property name="closed" column="Closed" ormtype="int"; 
	//property name="supplierid" column="SupplierID" ormtype="int"; 	
	property name="item" type="array" fieldtype="one-to-many" cfc="item" linktable="JoinCartToItem" ;
	//property name="supplier" fieldtype="one-to-one" cfc="supplier" fetch="join" column="id" ;
	//property name="item" fieldtype="one-to-many" cfc="item" type="array" linktable="JoinOrderToItem";
	//property name="closed" column="Closed" ormtype="int"; 
	property name="supplier" fieldtype="one-to-one" cfc="supplier" fkcolumn="SupplierID";
	
	}