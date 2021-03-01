component  {
  remote any function getUserDetails(){
    try {
      result = application.adminobj.adduser (userdetails = deserializeJSON(formdata))
    }
    catch (any e) {
      result = {'error' : true}
    }
  }
}