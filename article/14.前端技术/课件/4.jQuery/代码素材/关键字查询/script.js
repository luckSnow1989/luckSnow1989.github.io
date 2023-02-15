$(function(){
    $("#filterName").keyup(function(){
        $("table tbody tr").hide().filter(":contains('" + ($(this).val()) + "')").show();
    });
});
