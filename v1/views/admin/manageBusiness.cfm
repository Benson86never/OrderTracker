<cfoutput>    
    <div class="container table-responsive">
    <div class = "col-xs-12 sectionHeader" style="font-size:22px;padding-top:40px;">
      Manage Business
    </div>
      <table class="table table-bordered table-hover table-striped" cellspacing = "0" id="sortTable">
        <thead>
          <tr>
              <th style="display:none;">&nbsp;</th>
              <th style="text-align:center;">Business Name</th>
              <th class="hidden-xs" style="text-align:center;">Email</th>
              <th class="hidden-xs hidden-sm" style="text-align:center;">Mobile Number</th>
              <th class="hidden-xs hidden-sm" style="text-align:center;">Zip</th>
              <th class="hidden-xs hidden-sm" style="text-align:center;">City</th>
              <th class="hidden-xs hidden-sm" style="text-align:center;">State</th>
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
                <td class="hidden-xs">#business.Email#</td>
                <td class="hidden-xs hidden-sm">#business.Phone#</td>
                <td class="hidden-xs hidden-sm">#business.zip#</td>
                <td class="hidden-xs hidden-sm">#business.City#</td>
                <td class="hidden-xs hidden-sm">#business.State#</td>
                <td class="text-center">
                <cfif session.secure.rolecode eq 1>
                    <button class="btn btn-danger deactivateUser" businessId="#business.BusinessId#">
                      <i class="fa fa-trash" aria-hidden="true"></i>
                    </button>
                </cfif>
                    <a href="index.cfm?action=admin.addBusiness&businessId=#encrypt(business.BusinessId, application.uEncryptKey, "BLOWFISH", "Hex")#"
                      class = "btn btn-success">
                      <i class="fa fa-pencil" aria-hidden="true"></i>
                    </a>
                    <a href="index.cfm?action=admin.manageusers&businessId=#encrypt(business.BusinessId, application.uEncryptKey, "BLOWFISH", "Hex")#"
                      class = "btn btn-info">
                      <i class="fa fa-user" aria-hidden="true"></i>
                    </a>
                </td>
              </tr>  
            </cfloop>
          </cfif>
        </tbody>
      </table>
    </div>
</cfoutput>