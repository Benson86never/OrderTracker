component persistent="true" {
	property name="id" column="UnitID" fieldtype="id" generator="increment";
	property name="name" column="Name" ormtype="string";
	//property name="item" fieldtype="one-to-one" cfc="item" mappedby="units";

}
