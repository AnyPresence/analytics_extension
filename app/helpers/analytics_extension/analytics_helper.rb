module AnalyticsExtension
  module AnalyticsHelper
    def chart_tag(params = {})
      params[:format] ||= :json
      path = last_metric_path(params)
      mode = ""
      mode = @metric.blank? ? "" : "computed_metric"
      content_tag(:div, :id => 'visualization', :'data-chart' => path, :'data-api-versions' => @chosen_api_versions, :'data-mode' => mode, :style => "width: 75%; height: 300px;") do
        #image_tag('spinner.gif', :size => '24x24', :class => 'spinner')
      end
    end
  end
end
