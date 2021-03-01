component accessors="true" {
  property adminService;
  remote void function manageuser(rc){
    rc.response = adminService.manageuser(
      personId = rc.userId,
      active = rc.active
    );
  }
}