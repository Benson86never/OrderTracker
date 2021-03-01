component accessors="true" {
  property adminService;
  remote void function manageuser(rc){
    rc.response = adminService.manageuser(
      personId = rc.userId,
      active = rc.active
    );
  }
  remote void function manageBusiness(rc){
    rc.response = adminService.manageBusiness(
      businessId = rc.businessId,
      active = rc.active
    );
  }
}