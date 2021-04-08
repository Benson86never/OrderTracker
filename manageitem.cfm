<cfinclude template="includes/secure.cfm" >
<cfinclude template="includes/header.cfm" >
<style>
.steps {
  padding-left: 0;
  list-style: none;
  font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
  font-size: 12px;
  line-height: 1;
  margin: 30px auto;
  border-radius: 3px;
}

.steps strong {
  font-size: 14px;
  display: block;
  line-height: 1.4;
}

.steps>li {
  position: relative;
  display: block;
  /* border: 1px solid #ddd; */
  padding: 12px 50px 8px 50px; 
  width: 290px;
  height: 40px;
}

@media (min-width: 768px) {
  .steps>li { float: left; }
  .steps li { color: #666; background: #8BBFE6; }
  .steps .active { color: #000; background: #3E95D6;}
  /*.steps .future { color: #777; background: #8BBFE6; }*/

  .steps li > span:after,
  .steps li > span:before {
    content: "";
    display: block;
    width: 0px;
    height: 0px;
    position: absolute;
    top: 0;
    left: 0;
    border: solid transparent;
    border-left-color: #8BBFE6;
    border-width: 30px;
  }

  .steps li > span:after {
    top: -5px;
    z-index: 1;
    border-left-color: white;
    border-width: 34px;
  }

  .steps li > span:before { z-index: 2; }

  .steps li + li > span:before { border-left-color: #8BBFE6; }
  .steps li.active + li > span:before { border-left-color: #3E95D6; }
  .steps li.future + li > span:before { border-left-color: #8BBFE6; }

  .steps li:first-child > span:after,
  .steps li:first-child > span:before { display: none; }

  /* Arrows at start and end */
  .steps li:first-child i,
  .steps li:last-child i {
    display: block;
    position: absolute;
    top: 0;
    left: 0;
    border: solid transparent;
    border-left-color: white;
    border-width: 30px;
  }

  .steps li:last-child i {
    left: auto;
    right: -30px;
    border-left-color: transparent;
    border-top-color: white;
    border-bottom-color: white;
  }
}
.tab-pane{
  position: relative;
  top: 40px;
}
</style>
<cfif listfind(session.secure.businessType, 2)
OR session.secure.RoleCode EQ 1>
  <cfparam  name="url.page" default="items">
<cfelse>
  <cfparam  name="url.page" default="listitems">
</cfif>
<div class="container">
  <ul class="steps">
    <cfif listfind(session.secure.businessType, 2)
      OR session.secure.RoleCode EQ 1>
      <li <cfif url.page EQ "items">class="active"</cfif>>
        <span>
          <strong><a data-toggle="tab" href="items">Items</a></strong>
          Add/edit/delete list of items
        </span><i></i>
      </li>
    </cfif>
    <li <cfif url.page EQ "listitems">class="active"</cfif>>
      <span>
        <strong><a data-toggle="tab" href="listitems">Manage List Items</a></strong>
        Add/remove items to list
      </span><i></i>
    </li>
    <li <cfif url.page EQ "listorganize">class="active"</cfif>>
      <span>
        <strong><a data-toggle="tab" href="listorganize">Organize Lists</a></strong>
        Change order of items
      </span><i></i>
    </li>
  </ul>
  <div class="tab-content">
    <div id="items" class="tab-pane">
    <cfif isdefined("url.err") and url.err eq 1>
      <cfinclude template="item.cfm?err=1">
      <cfelse>
      <cfinclude template="item.cfm">
      </cfif>
    </div>
    <div id="listitems" class="tab-pane">
      <cfinclude template="list_item.cfm">
    </div>
    <div id="listorganize" class="tab-pane">
      <cfinclude template="list_organize.cfm">
    </div>
  </div>
</div>
<cfinclude template="includes/footer.cfm" >
<script>
  page = '<cfoutput>#url.page#</cfoutput>'
  function showtab(setId) {
    $('.tab-pane').hide();
    $('#'+setId).show();
  }
  $('li').click(function(){
    showtab($(this).find('a').attr('href'));
  });
  showtab(page);
 $(function() { 
    /*// for bootstrap 3 use 'shown.bs.tab', for bootstrap 2 use 'shown' in the next line
    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
        // save the latest tab; use cookies if you like 'em better:
        localStorage.setItem('lastTab', $(this).attr('href'));
    });

    // go to the latest tab, if it exists:
    var lastTab = localStorage.getItem('lastTab');
    if (lastTab) {
        $('[href="' + lastTab + '"]').tab('show');
    }*/
});
</script>