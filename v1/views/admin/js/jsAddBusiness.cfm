
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/3/jquery.inputmask.bundle.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.0/themes/smoothness/jquery-ui.css" />
<script src = "https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script>
  $(document).ready(function(){
    $(":input").inputmask();
    $("#Phone").inputmask({"mask": "(999) 999-9999"});
    $('#Email').on('keypress,blur', function() {
        var emailRegex = /([A-Z0-9a-z_-][^@])+?@[^$#<>?]+?\.[\w]{2,4}/.test(this.value);
        if(!emailRegex) {
            $('#Email').css("border-color","red");
        } 
        else {
            $('#Email').css("border-color","");
        }
    });
    $('#phoneExtension, #Zip').keypress(function(event){
      if(event.which > 57 || event.which < 48){
          event.preventDefault();
      }
    });
  });

  function disableBusinesses() {
    if(document.getElementById('subBusiness').checked == true) {
      document.getElementById('parentBusinessId').style.display = "block";
    } else {
      document.getElementById('parentBusinessId').style.display = "none";
    }
  }
  <cfif isDefined("url.businessId") && url.businessId NEQ 0>
    $(document).ready(function(){
      $('[data-toggle="tooltip"]').tooltip();
      var actions = $("table td:last-child").html();
      // Append table with add row form on add new button click
      $(".add-new").click(function(){
        $(this).attr("disabled", "disabled");
        var index = $("table tbody tr:last-child").index();
        var row = '<tr>' +
          '<td><input type="text" class="form-control" name="name" id="name"></td>' +
          '<td>' + actions + '</td>' +
          '</tr>';
        $("table").append(row);		
        $("table tbody tr").eq(index + 1).find(".add, .edit").toggle();
      });
      // Add row on add button click
      $(document).on("click", ".add", function(){
        var empty = false;
        var input = $(this).parents("tr").find('input[type="text"]');
            input.each(function(){
          if(!$(this).val()){
            $(this).addClass("error");
            empty = true;
          } else{
            $(this).removeClass("error");
          }
        });
        $(this).parents("tr").find(".error").first().focus();
        if(!empty){
          input.each(function(){
            $(this).parent("td").html($(this).val());
          });
          $(this).parents("tr").find(".add, .edit").toggle();
          $(".add-new").removeAttr("disabled");
          $.ajax({
            url: '../v1/model/services/admin.cfc?method=addSupplier',
            type: 'post',
            data: {
              name : $(this).val()
            },
            success: function(data){
              location.reload();
            }
          });
        }		
      });

      // Edit row on edit button click
      $(document).on("click", ".edit", function(){		
            $(this).parents("tr").find("td:not(:last-child)").each(function(){
          $(this).html('<input type="text" class="form-control" value="' + $(this).text() + '">');
        });		
        $(this).parents("tr").find(".add, .edit").toggle();
        $(".add-new").attr("disabled", "disabled");
        });
      // Delete row on delete button click
      $(document).on("click", ".delete", function(){
            $(this).parents("tr").remove();
        $(".add-new").removeAttr("disabled");
        });
    });

    <cfoutput>
      $(function() {
        $(".seller").each(function(){
          var element = $(this).attr('id');
          var target = $(this).attr('target');
          $('##'+ element).autocomplete({
            source: [
              <cfloop array="#rc.businessDetails[1].sellers#" index="i" item="seller">
                { label: "#seller.firstname# #seller.lastname#", value: "#seller.personid#" }
                <cfif i NEQ arraylen(rc.businessDetails[1].sellers)>,</cfif>
              </cfloop>
            ],
            select: function (event, ui) {
              // Set selection
              $('##'+element).val(ui.item.label); // display the selected text
              $('##'+target).val(ui.item.value); // save selected id to input
              return false;
            }
          });
        })
      });
      $('.saveseller').click(function() {
        var sellers = {};
        var suppliers = {};
        currentlist = "";
        <cfloop array="#rc.supplierDetails#" item="supplier" >
          <cfif arraylen(supplier.seller)>
            <cfloop array="#supplier.seller#" index="sellerindex" item="seller">
              supplierid = 'sellerid_#supplier.id#_#sellerindex#';
              currentvalue = $('##'+ supplierid).val();
              if(currentlist.length > 0) {
                currentlist = currentlist + ',' + currentvalue;
              } else {
                currentlist = currentvalue
              }
              
            </cfloop>
          <cfelse>
            supplierid = 'sellerid_#supplier.id#_1';
            currentvalue = $('##'+ supplierid).val();
            currentlist = currentvalue;
          </cfif>
          sellers[supplierid] = currentlist;
          suppliers['supplier_#supplier.id#'] = $( "##supplier_#supplier.id#" ).prop("checked");
        </cfloop>
        $.ajax({
          url: '../v1/model/services/admin.cfc?method=manageSeller',
          type: 'post',
          data: {
            sellers : JSON.stringify(sellers),
            suppliers : JSON.stringify(suppliers),
            businessid : '#variables.businessId#'
          },
          success: function(data){
            //location.href = "";
          }
        });
      })
    </cfoutput>
  </cfif>
</script>