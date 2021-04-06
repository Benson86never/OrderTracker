<!--- Global modals --->
<!--- Global alert modal --->
<div class="modal fade modal-warning" id="modal-showAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="z-index: 9000;">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <span id="headerText"></span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel"></h4>
      </div>
      <div class="modal-body"></div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default ok" data-dismiss="modal"><cfoutput>OK</cfoutput></button>
        <button type="button" class="btn btn-default no" data-dismiss="modal"><cfoutput>Cancel</cfoutput></button>
        <button type="button" class="btn btn-success yes" data-dismiss="modal"><cfoutput>Yes</cfoutput></button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade modal-warning" id="modal-supplierNotfound" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="z-index: 9000;">
  <div class="modal-dialog modal-lg" role="document">
    <cfparam name="rc.businessId" default="">
    <form class="form-inline" method = "post" id="formSubmit" name="formSubmit" action="index.cfm?action=admin.requestSupplier">
      <div class="modal-content">
        <div class="modal-header">
          <span id="headerText"></span>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" id="myModalLabel">Supplier Request</h4>
        </div>
        <div class="modal-body">
          <div class="modal-container">
          <div class="row">
            <div class="col-md-2 mlabelname">
                Supplier:
            </div>
            <div class="col-md-2 ">
                <input type="text" class="form-control inputelement" id="business" placeholder="Enter Business" name="business" value="" autocomplete="off" required>
                <input type ="hidden" id="businessId" name="businessId" value="">
            </div>
          </div>
          <div class="row">
              <div class="col-md-2 mlabelname">
                  Street <br> Address 1:
              </div>
              <div class="col-md-2 ">
                  <input type="text" class="form-control inputelement" id="address1" placeholder="Enter Street Address 1" name="address1" value="" autocomplete="off">
              </div>
              <div class="col-md-2 mlabelname">
                  Street <br> Address 2:
              </div>
              <div class="col-md-2 ">
                  <input type="text" class="form-control inputelement" id="address2" placeholder="Enter  Street Address 2" name="address2" value="" autocomplete="off">
              </div>
          </div>
            <div class="row">
              <div class="col-md-2 mlabelname">
                  Zip/Postal Code:
              </div>
              <div class="col-md-2 ">
                  <input type="text" class="form-control inputelement" id="Zip" placeholder="Enter Zip" name="Zip"  value="" autocomplete="off">
              </div>
              <div class="col-md-2 mlabelname">
                  City:
              </div>
              <div class="col-md-2 ">
                  <input type="text" class="form-control inputelement" id="City" placeholder="Enter City" name="City" value="" autocomplete="off" value="">
              </div>
          </div>
          <div class="row">
              <div class="col-md-2 mlabelname">
                  State/Province:
              </div>
              <div class="col-md-2 ">
                  <input type="text" class="form-control inputelement" id="state" placeholder="Enter State" name="state" value="" autocomplete="off" value="">
              </div>
              <div class="col-md-2 mlabelname">
                    Country:
              </div>
              <div class="col-md-2">
                  <input type="text" class="form-control inputelement" id="country" placeholder="Enter country" name="country" value="" autocomplete="off" value="">
              </div>
          </div>
          <div class="row">
              <div class="col-md-2 mlabelname">
                  Email<span style="color: red"><b>*<b></span>:
              </div>
              <div class="col-md-2  required">
                  <input type="text" class="form-control inputelement" id="Email" placeholder="Enter Email" name="Email" value="" required autocomplete="off">
              </div>
              <div class="col-md-2 mlabelname">
                  Phone:
              </div>
              <div class="col-md-2">
                  <input type="text" class="form-control inputelement" id="Phone" placeholder="(___)-___-____" name="Phone" value="" autocomplete="off" style="width: 95%"> 
              </div>
              <div class="col-md-1 ">
                  <input type="text" class="form-control inputelement" id="phoneExtension" placeholder="12345" name="phoneExtension" value="" autocomplete="off" style="width: 43%">  
              </div>
          </div>
        </div>
        </div>
        <div class="modal-footer">
          <input type="hidden" name="encBusinessId" value="<cfoutput>#rc.businessId#</cfoutput>">
          <button type="submit"  class="btn btn-default ok" name="supplierrequest" id="save" ><cfoutput>Submit</cfoutput></button>
          <button type="button" class="btn btn-default no" data-dismiss="modal"><cfoutput>Cancel</cfoutput></button>
        </div>
      </div>
    </form>
  </div>
</div>
<!--- Page specific modals --->
<cfif isdefined('rc')
  AND structKeyExists(rc, 'action')>
  <cfset viewsPath = expandPath('.') & '/views/'>
  <cfset modalView = replace(rc.action,'.','/modals/modal')>
  <cfset modalFile = viewsPath & modalView & '.cfm'>
  <cfif FileExists(modalFile)>
    <cfoutput>#view(modalView)#</cfoutput>
  </cfif>
</cfif>