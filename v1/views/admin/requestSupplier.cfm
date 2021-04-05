<cfsavecontent variable="mailcontent">
  <cfoutput>
    <table>
      <tr>
        <td colspan="2">Please find the new supplier information</td>
      </tr>
      <tr>
        <td>Name:</td>
        <td>#form.business#</td>
      </tr>
      <tr>
        <td>Address1:</td>
        <td>#form.address1#</td>
      </tr>
      <tr>
        <td>Address2:</td>
        <td>#form.address2#</td>
      </tr>
      <tr>
        <td>City:</td>
        <td>#form.city#</td>
      </tr>
      <tr>
        <td>State:</td>
        <td>#form.state#</td>
      </tr>
      <tr>
        <td>Country:</td>
        <td>#form.country#</td>
      </tr>
      <tr>
        <td>Zip:</td>
        <td>#form.zip#</td>
      </tr>
      <tr>
        <td>Email:</td>
        <td>#form.email#</td>
      </tr>
    </table>
  </cfoutput>
</cfsavecontent>
<cfmail from = "info@porthousegrill.com"
  <!---to = "info@porthousegrill.com"--->
  to = "bmadaveni@infoane.com"
  subject = "New Supplier Request">
  #mailcontent#
</cfmail>
<cflocation url="index.cfm?action=admin.addBusiness&businessId=#form.encBusinessId#"  addtoken="false">