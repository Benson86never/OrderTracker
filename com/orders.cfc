component persistent="true" {

	property name="id" column="OrderID" fieldtype="id" generator="native";
	property name="datetime" column="DateTime" ormtype="timestamp";
	property name="subaccountid" column="SubAccountID" ormtype="int"; 
	property name="supplierid" column="SupplierID" ormtype="int";
	property name="personid" column="PersonID" ormtype="int";  	
	property name="item" type="array" fieldtype="one-to-many" cfc="item" linktable="JoinOrderToItem" orderby="supplierid" ;
	//property name="supplier" fieldtype="one-to-one" cfc="supplier" fetch="join" column="id" ;
	//property name="item" fieldtype="one-to-many" cfc="item" type="array" linktable="JoinOrderToItem";
	property name="closed" column="Closed" ormtype="int"; 
	property name="checkedin" column="CheckedIn" ormtype="int"; 

	//property name="supplier" fieldtype="one-to-one" cfc="supplier" fkcolumn="SupplierID";
	
	}