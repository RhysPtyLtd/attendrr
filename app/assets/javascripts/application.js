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
} );