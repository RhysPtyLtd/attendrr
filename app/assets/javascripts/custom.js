$(document).on("turbolinks:load",function() {



    // Setup - add a text input to each footer cell
    var title = $('#products tfoot th:first').text();
    $('#products tfoot th:first').html( '<input type="text" placeholder="Search '+title+'" />' );

    var dataTable = $('#products').DataTable( {
        searching: true,
        "sDom":"ltipr",
        sAjaxSource: $('#products').data('source'),
        initComplete: function () {
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
                    });

                column.data().unique().sort().each( function ( d, j ) {
                    select.append( '<option value="'+d+'">'+d+'</option>' )
                });
            });

            this.api().columns([0]).every( function () {
                var column = this;
            $( 'input', this.footer() ).on( 'keyup change clear', function () {
                        if ( column.search() !== this.value ) {
                            column
                                .search( this.value )
                                .draw();
                        }
                    });
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
