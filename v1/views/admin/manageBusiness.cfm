<style>
  @media (max-width: 767px) {
     .sectionHeader {
        font-size:12px !important;
        margin-left: 10px !important;

     }
    #status {
      width: 100px !important;
       }
       .container {
  padding: 0 !important;
  margin: 0 !important;
}
   }
</style>
<cfoutput>
  <cfparam name="url.status" default="1">
  <cfif NOT listfind('1,0', url.status)
    AND url.status NEQ ''>
      <cfset url.status = 1>
  </cfif>
  <div class="container">
    <div class="row">
      <div class = "col-xs-2 sectionHeader" style="font-size:22px;padding-top:40px;">
        Manage Business
      </div>
      <cfif session.secure.rolecode EQ 1>
        <div class="col-xs-2" style="padding-top:40px;">
          <select name="status" id="status" class="form-control">
            <option value="1" <cfif url.status EQ 1>selected</cfif>>Active</option>
            <option value="0" <cfif url.status EQ 0>selected</cfif>>InActive</option>
            <option value="" <cfif url.status EQ "">selected</cfif>>All</option>
          </select>
        </div>
      </cfif>
    </div>
    <table class="table table-bordered table-hover table-striped table-responsive-sm" cellspacing = "0" id="sortTable">
      <thead>
        <tr>
            <th style="display:none;">&nbsp;</th>
            <th style="text-align:center;">Business Name</th>
            <th style="text-align:center;">Business Type</th>
            <th class="hidden-xs" style="text-align:center;">Email</th>
            <th class="hidden-xs hidden-sm text-center">Mobile Number</th>
            <th class="hidden-xs hidden-sm text-center">Zip</th>
            <th class="hidden-xs hidden-sm text-center">City</th>
            <th class="hidden-xs hidden-sm text-center">State</th>
            <th class="no-sort text-center">
              Action
              <cfif session.secure.rolecode eq 1>
              <a class="btn btn-success" href="index.cfm?action=admin.addBusiness">
                <i class="fa fa-plus" aria-hidden="true"></i>
              </a>
              </cfif>
            </th>
        </tr>
      </thead>
      <tbody>
        <cfif NOT arrayLen(rc.businessDetails)>
          <tr>
            <td colspan="7">No Business available</td>
          </tr>
        <cfelse>
          <cfloop array="#rc.businessDetails#" item="business">
            <tr>
              <td style="display:none;">#business.sortBusinessName#</td>
              <td width=300px; >
                <span class="business-#listlen(business.sortBusinessName,'~~')#">
                    #business.BusinessName#
                </span>
              </td>
              <td>#business.businessTypes#</td>
              <td class="hidden-xs">#business.Email#</td>
              <td class="hidden-xs hidden-sm">#business.Phone#</td>
              <td class="hidden-xs hidden-sm text-center" style="width:100px;">#business.zip#</td>
              <td class="hidden-xs hidden-sm text-center">#business.City#</td>
              <td class="hidden-xs hidden-sm text-center">#business.Statecode#</td>
              <td class="text-center">
                <cfif session.secure.rolecode eq 1>
                  <cfif business.active EQ 1>
                    <button class="btn btn-danger deactivateBusiness" businessname = "#business.BusinessName#"
                      businessId="#business.BusinessId#">
                      <i class="fas fa-store-slash"></i>
                    </button>
                  <cfelse>
                    <button class="btn btn-warning reactivateBusiness" businessname = "#business.BusinessName#"
                      businessId="#business.BusinessId#">
                      <i class="fas fa-store"></i>
                    </button>
                  </cfif>
                </cfif>
                <cfif business.active EQ 1>
                  <a href="index.cfm?action=admin.addBusiness&businessId=#encrypt(business.BusinessId, application.uEncryptKey, "BLOWFISH", "Hex")#"
                    class = "btn btn-success">
                    <i class="fas fa-pencil-alt"></i>
                  </a>
                  <a href="index.cfm?action=admin.manageusers&businessId=#encrypt(business.BusinessId, application.uEncryptKey, "BLOWFISH", "Hex")#"
                    class = "btn btn-info">
                    <i class="fa fa-user" aria-hidden="true"></i>
                  </a>
                </cfif>
              </td>
            </tr>  
          </cfloop>
        </cfif>
      </tbody>
    </table>
  </div>
</cfoutput>