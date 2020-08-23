$(document).on("turbolinks:load",function() {
  var title = $('#products tfoot th:first').text();
  $('#products tfoot th:first').html( '<input type="text" placeholder="Search '+title+'" />' );
  
  var dataTable = $('#products').DataTable( {
    sPaginationType: "full_numbers",
    bJQueryUI: true,
    searching: true,
    bProcessing: true,
    bServerSide: true,
       "language": {
        "infoFiltered": ""
     },

    sAjaxSource: $('#products').data('source'),
      initComplete: function () {
        this.api().column(0).every( function () {
          var that = this;

          $('input', this.footer()).on( 'keyup change', function () {
              if ( that.search() !== this.value ) {
                that
                  .search( this.value )
                  .draw();
              }
          } );
        });

        this.api().columns([1,2,3]).every( function () {
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
        });
      }
    });
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
        });
      }
    });
   document.addEventListener("turbolinks:before-cache", function() {
   if ($('#metrics').length == 1) {
     dataTable.destroy();
   }
 });
});