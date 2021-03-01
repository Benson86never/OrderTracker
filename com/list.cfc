component persistent="true" displayname="Lists" hint="Lists of items" {
	
	property name="id" column="ListID" fieldtype="id" generator="native";  
	property name="name" column="Name" ormtype="string";
	property name="subaccountid" column="SubAccountID" ormtype="int";
	property name="orderby" column="Orderby" ormtype="int";
	property name="item" type="array" fieldtype="one-to-many" cfc="item" linktable="JoinItemToList" orderby="OrderBy asc" ;
}