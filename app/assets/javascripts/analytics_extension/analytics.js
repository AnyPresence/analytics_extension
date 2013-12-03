// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var MONTHS = [ "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December" ];

$(function () {
  var data = {
      labels : ["January","February","March","April","May","June","July"],
      datasets : [
        {
          fillColor : "rgba(151,187,205,0.5)",
          strokeColor : "rgba(151,187,205,1)",
          pointColor : "rgba(151,187,205,1)",
          pointStrokeColor : "#fff",
          data : [28,48,40,19,96,27,100]
        }
      ]
    };

    //alert("data is " + data);

    $('[data-chart]').each(function () {
      var div = $(this);
      var api_versions = div.data('versions');

      $.post(div.data('chart'), {mode: div.data('mode')}, function (data) {
        getCharts(data, "visualization");
      });
    })



});

function getLabels(xAxisLabels) {
  var labels = new Array();

  var skipStep = (xAxisLabels.length/8).toFixed();

  $.each(xAxisLabels, function(index, value) {
    if (index == 0 || index % skipStep == 0) {
      labels.push(value.getDate() + "." + MONTHS[value.getMonth()]);
    } else {
      labels.push("");
    }
  });

  return labels;
}

$(function () {
  $('#start_date').datepicker();
  $('#end_date').datepicker();

  $('form[data-update-chart]').live('ajax:success', function(evt, data) {
      getCharts(data, 'visualization');
  });
});

function getCharts(data, target_div) {
  var values = new Array();
  var startDate = null;
  var xAxisLabels = new Array();

  $.each(data, function(time, value) {
    var date = new Date(time);
    // Convert to UTC
    date = new Date(date.getTime() + (date.getTimezoneOffset() * 60000));
    if (startDate == null) {
      startDate = date;
    }

    xAxisLabels.push(date);
    values.push(value);
  });

  var data = {
      labels : getLabels(xAxisLabels),
      datasets : [
        {
          fillColor : "rgba(151,187,205,0.5)",
          strokeColor : "rgba(151,187,205,1)",
          pointColor : "rgba(151,187,205,1)",
          pointStrokeColor : "#fff",
          data : values
        }
      ]
    };

  var ctx = $("#" + target_div).get(0).getContext("2d");
  new Chart(ctx).Line(data, {});
}

