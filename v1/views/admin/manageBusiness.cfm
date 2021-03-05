<cfoutput>
    <div class = "col-xs-12 sectionHeader">
      Manage Business
    </div>
    <div class="container table-responsive">
      <table class="table table-bordered table-hover table-striped" cellspacing = "0" id="sortTable">
        <thead>
          <tr>
              <th style="display:none;">&nbsp;</th>
              <th>Business Name</th>
              <th class="hidden-xs">Email</th>
              <th class="hidden-xs hidden-sm">Mobile Number</th>
              <th class="hidden-xs hidden-sm">Zip</th>
              <th class="hidden-xs hidden-sm">City</th>
               <th class="hidden-xs hidden-sm">State</th>
              <th class="no-sort text-center">
                Action
                <a class="btn btn-success" href="index.cfm?action=admin.addBusiness">
                  <i class="fa fa-plus" aria-hidden="true"></i>
                </a>
              </th>              
          </tr>
        </thead>
        <tbody>
          <cfloop array="#rc.businessDetails#" item="business">
            <tr>
              <td style="display:none;">#business.sortBusinessName#</td>
              <td width=300px; >
                <span class="business-#listlen(business.sortBusinessName,'~~')#">
                    #business.BusinessName#
                </span>
              </td>
              <td class="hidden-xs">#business.Email#</td>
              <td class="hidden-xs hidden-sm">#business.Phone#</td>
              <td class="hidden-xs hidden-sm">#business.zip#</td>
              <td class="hidden-xs hidden-sm">#business.City#</td>
              <td class="hidden-xs hidden-sm">#business.State#</td>
              <td class="text-center">
                  <button class="btn btn-danger deactivateUser" businessId="#business.BusinessId#">
                    <i class="fa fa-trash" aria-hidden="true"></i>
                  </button>
                  <a href="index.cfm?action=admin.addBusiness&businessId=#encrypt(business.BusinessId, application.uEncryptKey, "BLOWFISH", "Hex")#"
                    class = "btn btn-success">
                    <i class="fa fa-pencil" aria-hidden="true"></i>
                  </a>
                  <a href="index.cfm?action=admin.manageusers&businessId=#encrypt(business.BusinessId, application.uEncryptKey, "BLOWFISH", "Hex")#"
                    class = "btn btn-success">
                    <i class="fa fa-pencil" aria-hidden="true"></i>
                  </a>
              </td>
            </tr>  
          </cfloop>
        </tbody>
      </table>
    </div>
</cfoutput>