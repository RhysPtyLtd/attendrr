$(document).on("turbolinks:load",function() {
  $('.popover-dismiss').popover({
    trigger: 'focus'
  })

  $('#demo_date_time_picker').datetimepicker()
  $( "#dropdown" ).select2({
    theme: "bootstrap"
  })
})
