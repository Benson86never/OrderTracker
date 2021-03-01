component persistent="true" table="JoinItemToList" displayname="Join Item To List" hint="Joins items to a list" {
	property name="id" column="ID" fieldtype="id" generator="native"; 
	property name="itemid" column="ItemID" ormtype="int";
	property name="listid" column="ListID" ormtype="int";
	property name="sequence" column="OrderBy" ormtype="int";
	
	}