// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

google.load('visualization',  '1', {packages: ['annotatedtimeline']});
google.setOnLoadCallback(
$(function () {
  $('[data-chart]').each(function () {
      var div = $(this);
      var api_versions = div.data('versions')
      $.post(div.data('chart'), {mode: div.data('mode')}, function (data) {
        get_charts(data, "visualization");
      });
  });
})
);

$(function () {
  $('#start_date').datepicker();
  $('#end_date').datepicker();
  
  $('form[data-update-chart]').live('ajax:success', function(evt, data) {
      var target = $(this).data('update-chart');
      get_charts(data, 'visualization');
  });
});

function get_charts(data, target_div) {
    var table = new google.visualization.DataTable();
    table.addColumn('date', 'Date');
    table.addColumn('number', 'Api Hits');
    table.addColumn('string', 'title1');
    table.addColumn('string', 'text1');
    $.each(data, function(time, value) {
      var date = new Date(time);
      // Convert to UTC
      date = new Date(date.getTime() + (date.getTimezoneOffset() * 60000));        
      table.addRow([date, value, null, null]);
    });
    var annotatedtimeline = new google.visualization.AnnotatedTimeLine(document.getElementById(target_div));
    annotatedtimeline.draw(table, {'displayAnnotations': true});
}
