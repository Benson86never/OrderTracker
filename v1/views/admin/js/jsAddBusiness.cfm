
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/3/jquery.inputmask.bundle.js"></script>
<link rel="stylesheet" href="../js/jquery-ui.css" />
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
      var actions = '<button class="deletesupplier btn btn-danger" id="0" title="Delete" ><i class="fa fa-trash-alt"></i></button>'+
                  '<button class="editsupplier btn btn-success" style="margin-left: 8px !important;" id="0" title="Edit" ><i class="fa fa-pencil-alt"></i></button>'+
                  '<button class="addsupplier btn btn-success" id="0" title="Add" ><i class="fa fa-plus"></i></button>';
      // Append table with add row form on add new button click
      $(".add-newsupplier").click(function(){
        $('#supplierid').val(0);
        $('#suppliername').val('');
        $('#sellerid').val(0);
        $(this).attr("disabled", "disabled");
        var index = $(".suppliertable tr").length;
        var row = '<tr>' +
          '<td><input type="text" class="form-control inputelement supplier" name="supplier" id="supplier"></td>' +
          '<td><input type="text" disabled class="form-control inputelement seller" name="seller" id="seller"></td>' +
          '<td>' + actions + '</td>' +
          '</tr>';
        $(".suppliertable").append(row);
        $(".suppliertable tbody tr").eq(index - 1).find(".addsupplier, .editsupplier").toggle();
        <cfoutput>
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
              $('##suppliername').val(ui.item.label);
              $('.seller').removeAttr('disabled');
              sarray = [];
              <cfloop array="#rc.sellerInfo#" index="seller">
                if(ui.item.value == '#seller.businessid#') {
                  <cfif len(trim(seller.firstname))>
                    sarray.push({ label: "#seller.firstname# #seller.lastname#", value: "#seller.personid#" });
                  <cfelse>
                    $('.seller').val('#seller.businessemail#');
                    $('##sellerid').val('#seller.businessemail#');
                    $('##seller').attr('disabled', 'disabled');
                  </cfif>
                }
              </cfloop>
              if(sarray.length > 0) {
                $('.seller').autocomplete({
                  source: sarray,
                  select: function (event, ui) {
                    // Set selection
                    $('##seller').val(ui.item.label); // display the selected text
                    $('##sellerid').val(ui.item.value); // save selected id to input
                    return false;
                  }
                });
              }
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
        suppliername = [];
        <cfloop array="#rc.suppliernames#" item="sname">
          suppliername.push('<cfoutput>#sname#</cfoutput>');
        </cfloop>
        if(suppliername.indexOf($('#supplier').val()) == -1) {
          $('#modal-supplierNotfound').modal('show');
          $('.modal-header').css('background-color','white');
          $('.close').css('color','black');
          $('#supplier').addClass("error");
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
              location.reload();
            }
          });
        }		
      });

      // Edit row on edit button click
      $(document).on("click", ".editsupplier", function(){
        supplierid = $(this).attr('supplierid');
        console.log(supplierid);
        $(this).parents("tr").find("td:not(:last-child)").each(function(){
          element = $(this).attr('element');
          if(element == 'seller') {
            $(this).html('<input type="text" class="form-control inputelement seller" name="seller" id="seller" value="' +$.trim($(this).text()) + '">');
          }
          sarray = [];
          <cfloop array="#rc.sellerInfo#" index="seller">
            businessid = '<cfoutput>#seller.businessid#</cfoutput>';
            console.log(businessid);
            if(supplierid == businessid) {
              sarray.push({ label: "<cfoutput>#seller.firstname# #seller.lastname#</cfoutput>",
              value: "<cfoutput>#seller.personid#</cfoutput>" });
            }
          </cfloop>
          console.log(sarray);
          <cfoutput>
            $('.seller').autocomplete({
              source:sarray,
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
            $(this).parent("td").html($('#dbsellername').val());
          });
        $(this).parents("tr").find(".deletesupplier, .editsupplier").toggle();
        $(this).parents("tr").find(".savesupplier, .cancelsupplier").toggle();
        $(".add-newsupplier").removeAttr("disabled");
      });
      // Delete row on delete button click
      $(document).on("click", ".deletesupplier", function(){
        $(this).parents("tr").remove();
        $(".add-newsupplier").removeAttr("disabled");
        if($(this).attr('supplierid') > 0) {
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
                location.reload();
              }
            });
        }
      });
      $(document).on('input', '#supplier', function() {
        if($('#suppliername').val().length > 0) {
          $('#suppliername').val('');
          $('#supplierid').val(0);
          $('#seller').val('');
          $('#sellerid').val(0);
          $('#seller').attr('disabled', 'disabled');
        }
      })
      $(document).on('input', '#seller', function() {
        if($('#sellername').val().length > 0) {
          $('#sellername').val('');
          $('#sellerid').val(0);
        }
      })
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
  </cfif>
</script>