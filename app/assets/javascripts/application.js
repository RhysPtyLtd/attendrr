// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require turbolinks
//= require bootstrap
//= require jquery_nested_form
//= require moment
//= require bootstrap-datetimepicker
//= require select2
//= require chartkick
//= require_tree .

$(document).on("turbolinks:load",function() {
   var dataTable = $('#products').DataTable( {
    	sPaginationType: "full_numbers",
    	bJQueryUI: true,
    	bProcessing: true,
    	bServerSide: true,
         "language": {
          "infoFiltered": ""
       },

    	sAjaxSource: $('#products').data('source'),
        initComplete: function () {
            this.api().columns([0,1,2,3]).every( function () {
                var column = this;
                var select = $('<select><option value="">All</option></select>')
                    .appendTo( $(column.footer()).empty() )
                    .on( 'change', function () {
                        var val = $.fn.dataTable.util.escapeRegex(
                            $(this).val()
                        );

                        column
                            .search( val ? val : '', true, false )
                            .draw();
                    } );

                column.data().unique().sort().each( function ( d, j ) {
                    select.append( '<option value="'+d+'">'+d+'</option>' )
                } );
            } );
        }
    } );
    document.addEventListener("turbolinks:before-cache", function() {
	  if ($('#products').length == 1) {
	  	dataTable.destroy();
	  }
	});

  var dataTable = $('#metrics').DataTable( {
     bPaginate: false,
     bJQueryUI: true,
     bProcessing: true,
     aoColumnDefs : [
     {
       'bSortable' : false,
       'aTargets' : [ 1, 2, 3, 4, 5 ]
     }],
     bServerSide: true,
        "language": {
         "infoFiltered": ""
      },

     sAjaxSource: $('#metrics').data('source'),
       initComplete: function () {
           this.api().columns([1,2,3,4,5]).every( function () {
              var total = 0
              var sum = this
              .data()
              .reduce(function(a, b) {
                var x = parseFloat(a) || 0;
                var y = parseFloat(b) || 0;
                total++;
                return x + y;
              }, 0);
              sum = (this[0] != 3 && this[0] != 4)? ( sum.toFixed(2) / total.toFixed(2) ).toFixed(2) : sum
              sum = (this[0] == 5)? sum+"%": sum;
            $(this.footer()).html("<b>"+sum+"</b>");
           } );
       }
   } );
   document.addEventListener("turbolinks:before-cache", function() {
   if ($('#metrics').length == 1) {
     dataTable.destroy();
   }
 });
} );
