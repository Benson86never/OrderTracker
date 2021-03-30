<cfoutput>
    <div class = "col-xs-12 sectionHeader" style="font-size:22px;margin-left:360px;padding-top:40px;">
     Manage Users
    </div>
    <div class="container table-responsive">
      <table class="table table-bordered table-hover table-striped" cellspacing = "0" id="sortTable">
        <thead>
          <tr>
              <th style="text-align:center;">First Name</th>
              <th style="text-align:center;">Last Name</th>
              <th class="hidden-xs" style="text-align:center;">Email</th>
              <th class="hidden-xs hidden-sm" style="text-align:center;">Business</th>
              <th class="hidden-xs hidden-sm" style="text-align:center;">Type</th>
              <th class="no-sort text-center">
                Action
                <a class="btn btn-success" href="index.cfm?action=admin.adduser<cfif isdefined("url.businessid")>&businessid=#url.businessid#</cfif>">
                  <i class="fa fa-plus" aria-hidden="true"></i>
                </a>
              </th>
          </tr>
        </thead>
        <tbody>
          <cfloop array="#rc.userDetails#" item="userdetail">
            <tr>
              <td>#userdetail.firstname#</td>
              <td>#userdetail.lastName#</td>
              <td class="hidden-xs">#userdetail.email#</td>
              <td class="hidden-xs hidden-sm">#userdetail.subAccountName#</td>
              <td class="hidden-xs hidden-sm">#userdetail.type#</td>
              <td class="text-center">
                <cfif userdetail.active EQ 1>
                  <button class="btn btn-danger deactivateUser" userid="#userdetail.personId#">
                    <i class="fa fa-trash" aria-hidden="true"></i>
                  </button>
                <cfelseif userdetail.active EQ 0>
                  <button class="btn btn-info activateUser" userid="#userdetail.personId#">
                    <i class="fa fa-sign-in" aria-hidden="true"></i>
                  </button>
                <cfelseif userdetail.active EQ -1>
                  <button class="btn btn-warning reactivateUser" userid="#userdetail.personId#">
                    <i class="fa fa-times" aria-hidden="true"></i>
                  </button>
                </cfif>
                <a href="index.cfm?action=admin.adduser&userid=#encrypt(userdetail.personId, application.uEncryptKey, "BLOWFISH", "Hex")#"
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