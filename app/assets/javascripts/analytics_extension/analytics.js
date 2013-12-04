// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var MONTHS = [ "Jan", "Feb", "Mar", "Apr", "May", "June",
    "July", "Aug", "Sept", "Oct", "Nov", "Dec" ];

$(function () {
    $('[data-chart]').each(function () {
      var div = $(this);

      // Gets the last metric if there's any and plot it. Nothing will be shown
      // if there's none.
      $.post(div.data('chart'), {mode: div.data('mode')}, function(data) {
        getCharts(data, "visualization");
      });
    })
});

/*
 * Gets the labels for the x-axis for the time series line plot
 */
function getLabels(xAxisLabels) {
  var labels = new Array();

  // Show 1/8 th of the labels. This seems to be reasonable at this time. For a large
  // dataset, the x-axis labels overlap each other if each label is displayed.
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

/*
 * Constructs the chart that needs to be plotted
 */
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

