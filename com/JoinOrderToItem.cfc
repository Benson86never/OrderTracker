component persistent="true" {
	property name="id" type="numeric" ormtype="int" fieldtype="id" generator="identity" notnull="true" setter="false" length="11"; 
	property name="itemid" column="ItemID" ormtype="int";
	property name="orderid" column="OrderID" ormtype="int";
	property name="supplierid" column="SupplierID" ormtype="int";
	property name="quantity" column="QuantityOrdered" ormtype="int";
	property name="checkedin" column="CheckedIn" ormtype="int";
	
	}