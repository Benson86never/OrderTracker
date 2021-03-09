component persistent="true" {
	property name="id" column="PersonID" fieldtype="id" generator="native";
	property name="firstname" column="FirstName" ormtype="string";
	property name="lastname" column="LastName" ormtype="string";
	property name="email" column="Email" ormtype="string";
	property name="phone" column="Phone" ormtype="string";
	property name="carrier" column="Carrier" ormtype="string";
	property name="type" column="Type" ormtype="int";
	property name="password" column="Password" ormtype="string";
	property name="salt" column="Salt" ormtype="string";
	property name="businessId" column="subaccountId" ormtype="int";

}