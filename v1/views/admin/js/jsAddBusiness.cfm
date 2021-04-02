
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
  <cfif variables.businessId NEQ 0
    AND listfind(variables.businessType,1)>
    $(document).ready(function(){
      $('[data-toggle="tooltip"]').tooltip();
      var actions = '<button class="deletesupplier btn btn-danger" id="0" title="Delete" ><i class="fa fa-trash"></i></button>'+
                  '<button class="editsupplier btn btn-success" style="margin-left: 8px !important;" id="0" title="Edit" ><i class="fa fa-pencil"></i></button>'+
                  '<button class="addsupplier btn btn-success" id="0" title="Add" ><i class="fa fa-plus"></i></button>';
      // Append table with add row form on add new button click
      $(".add-newsupplier").click(function(){
        $(this).attr("disabled", "disabled");
        var index = $(".suppliertable tr").length;
        var row = '<tr>' +
          '<td><input type="text" class="form-control inputelement supplier" name="supplier" id="supplier"></td>' +
          '<td><input type="text" class="form-control inputelement seller" name="seller" id="seller"></td>' +
          '<td>' + actions + '</td>' +
          '</tr>';
        $(".suppliertable").append(row);
        $(".suppliertable tbody tr").eq(index - 1).find(".addsupplier, .editsupplier").toggle();
        <cfoutput>
          $('.seller').autocomplete({
            source: [
              <cfloop array="#rc.businessDetails[1].sellers#" index="i" item="seller">
                { label: "#seller.firstname# #seller.lastname#", value: "#seller.personid#" }
                <cfif i NEQ arraylen(rc.businessDetails[1].sellers)>,</cfif>
              </cfloop>
            ],
            select: function (event, ui) {
              // Set selection
              $('##seller').val(ui.item.label); // display the selected text
              $('##sellerid').val(ui.item.value); // save selected id to input
              return false;
            }
          });
          $('.supplier').autocomplete({
            source: [
              <cfloop array="#rc.newsupplierDetails#" index="i" item="supplier">
                { label: "#supplier.name#", value: "#supplier.id#" }
                <cfif i NEQ arraylen(rc.newsupplierDetails)>,</cfif>
              </cfloop>
            ],
            select: function (event, ui) {
              // Set selection
              $('##supplier').val(ui.item.label); // display the selected text
              $('##supplierid').val(ui.item.value); // save selected id to input
              return false;
            }
          });
        </cfoutput>
        
      });
      // Add row on add button click
      
      $(document).on("click", ".addsupplier", function(){
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
        if(!empty){
          if($('#sellerid').val() == 0) {
            empty = true;
            $('#seller').addClass("error");
          }
          if($('#supplierid').val() == 0) {
            empty = true;
            $('#supplier').addClass("error");
          }
        }
        $(this).parents("tr").find(".error").first().focus();
        if(!empty){
          input.each(function(){
            $(this).parent("td").html($(this).val());
          });
          $(this).parents("tr").find(".addsupplier, .editsupplier").toggle();
          $(".add-newsupplier").removeAttr("disabled");
          $.ajax({
            url: '../v1/model/services/admin.cfc?method=addSupplierSeller',
            type: 'post',
            data: {
              businessid : <cfoutput>#variables.businessId#</cfoutput>,
              sellerid : $('#sellerid').val(),
              supplierid : $('#supplierid').val()
            },
            success: function(data){
              //location.reload();
            }
          });
        }		
      });

      // Edit row on edit button click
      $(document).on("click", ".editsupplier", function(){		
        $(this).parents("tr").find("td:not(:last-child)").each(function(){
          element = $(this).attr('element');
          if(element == 'seller') {
            $(this).html('<input type="text" class="form-control inputelement seller" name="seller" id="seller" value="' +$.trim($(this).text()) + '">');
          }
          <cfoutput>
            $('.seller').autocomplete({
              source: [
                <cfloop array="#rc.businessDetails[1].sellers#" index="i" item="seller">
                  { label: "#seller.firstname# #seller.lastname#", value: "#seller.personid#" }
                  <cfif i NEQ arraylen(rc.businessDetails[1].sellers)>,</cfif>
                </cfloop>
              ],
              select: function (event, ui) {
                // Set selection
                $('##seller').val(ui.item.label); // display the selected text
                $('##sellerid').val(ui.item.value); // save selected id to input
                return false;
              }
            });
          </cfoutput>
        });		
        $(this).parents("tr").find(".deletesupplier, .editsupplier").toggle();
        $(this).parents("tr").find(".savesupplier, .cancelsupplier").toggle();
        $(".add-newsupplier").attr("disabled", "disabled");
      });
      $(document).on("click", ".cancelsupplier", function(){		
          $(this).parents("tr").find("input").each(function(){
            $(this).parent("td").html($(this).val());
          });
        $(this).parents("tr").find(".deletesupplier, .editsupplier").toggle();
        $(this).parents("tr").find(".savesupplier, .cancelsupplier").toggle();
        $(".add-newsupplier").removeAttr("disabled");
      });
      // Delete row on delete button click
      $(document).on("click", ".deletesupplier", function(){
        $(this).parents("tr").remove();
        $(".add-newsupplier").removeAttr("disabled");
        if($(this).attr('sellerid') > 0
          && $(this).attr('supplierid') > 0) {
            $.ajax({
              url: '../v1/model/services/admin.cfc?method=deleteSupplier',
              type: 'post',
              data: {
                businessid : <cfoutput>#variables.businessId#</cfoutput>,
                sellerid : $(this).attr('sellerid'),
                supplierid : $(this).attr('supplierid')
              },
              success: function(data){
                $(this).parents("tr").find(".addsupplier, .editsupplier").toggle();
                $(".add-newsupplier").removeAttr("disabled");
              }
            });
        }
      });
      // save seller
      $(document).on("click", ".savesupplier", function(){
        if($('#sellerid').val() > 0
          && $(this).attr('supplierid') > 0) {
            $(this).parents("tr").find(".deletesupplier, .editsupplier, .savesupplier, .cancelsupplier").toggle();
            $(".add-newsupplier").removeAttr("disabled");
            $(this).parents("tr").find("input").each(function(){
              $(this).parent("td").html($(this).val());
            });
            $.ajax({
              url: '../v1/model/services/admin.cfc?method=updateSeller',
              type: 'post',
              data: {
                businessid : <cfoutput>#variables.businessId#</cfoutput>,
                sellerid : $('#sellerid').val(),
                supplierid : $(this).attr('supplierid')
              },
              success: function(data){
                
              }
            });
        }
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