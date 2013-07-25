// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function () {
  $('[data-chart]').each(function () {
      var div = $(this);

      var api_versions = div.data('versions');
      
      $.post(div.data('chart'), {mode: div.data('mode')}, function (data) {
        get_charts(data, "visualization");
      });
  });
})

$(function () {
  $('#start_date').datepicker();
  $('#end_date').datepicker();
  
  $('form[data-update-chart]').live('ajax:success', function(evt, data) {
      var target = $(this).data('update-chart');
      get_charts(data, 'visualization');
  });
});

function get_charts(data, target_div) {
  var values = new Array();
  var startDate = null;

  $.each(data, function(time, value) {
    var date = new Date(time);
    // Convert to UTC
    date = new Date(date.getTime() + (date.getTimezoneOffset() * 60000));        
    if (startDate == null) {
      startDate = date;
    }
    values.push(value);
  });
  
  // Get time since epoch for highcharts
  var utc = Date.UTC(
      startDate.getFullYear(),
      startDate.getMonth(),
      startDate.getDate(),
      startDate.getHours(),
      startDate.getMinutes()
  );

  $("#" + target_div).highcharts({
    chart: {
           zoomType: 'x',
           spacingRight: 20
       },
       title: {
           text: 'Usage'
       },
       xAxis: {
           type: 'datetime',
             maxZoom: 14 * 24 * 3600000, // fourteen days
             title: {
                 text: null
             }
       },
       yAxis: {
         title: {
              text: 'Hits'
           }
       },
       series: [{
           type: 'area',
           name: 'hits',
           pointInterval: 24 * 3600 * 1000,
           pointStart:  utc,
           data: values
       }]
  });
}
