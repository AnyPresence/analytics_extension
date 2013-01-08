// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

google.load('visualization',  '1', {packages: ['annotatedtimeline']});
google.setOnLoadCallback(
$(function () {
  $('[data-chart]').each(function () {
    var div = $(this);
    $.getJSON(div.data('chart'), function (data) {
      var table = new google.visualization.DataTable();
      table.addColumn('date', 'Date');
      table.addColumn('number', 'Api Hits');
      $.each(data, function(time, value) {
        var date = new Date(time);        
        table.addRow([date, value]);
      });
      var annotatedtimeline = new google.visualization.AnnotatedTimeLine(document.getElementById('visualization'));
      annotatedtimeline.draw(table, {'displayAnnotations': true});
    });
  });
})
);


