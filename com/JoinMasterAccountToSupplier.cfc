component persistent="true" table="JoinMasterAccountToSupplier" {
	property name="id" type="numeric" ormtype="int" fieldtype="id" generator="identity" notnull="true" setter="false" length="11"; 
	property name="masterid" column="MasterID" ormtype="int";
	property name="supplierid" column="SupplierID" ormtype="int";
	
	}
