$(document).on("turbolinks:load",function() {
	change_plan();
	$('#plan_type').bind('change', function() {
		change_plan();
	});
	function change_plan(){
		if ($('#plan_type').val() ==  "Class package")
		{
			$('#div_classes_amount').show();
			$('#div_frequency').hide();
		}
		else if ($('#plan_type').val()  == "Regular recurring payments")
		{
			$('#div_frequency').show();
			$('#div_classes_amount').hide();
		}
	}

	$('#payment_plan_btn').unbind().click(function(e){
		if ($('#plan_type').val() == "Regular recurring payments" && $('#payment_plan_frequency').val() == "")
		{
			alert("You must select a frequency to proceed");
			e.preventDefault();
		}
		else if ($('#plan_type').val() == "Class package" && $('#payment_plan_classes_amount').val() == "")
		{
			alert("You must select a frequency to proceed");
			e.preventDefault();
		}
	});
});
