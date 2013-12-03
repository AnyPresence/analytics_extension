module AnalyticsExtension
  module AnalyticsHelper
    def chart_tag(params = {})
      params[:format] ||= :json
      path = last_metric_path(params)
      mode = ""
      mode = @metric.blank? ? "" : "computed_metric"

      content_tag(:canvas, :id => 'visualization', :'data-chart' => path, :'data-api-versions' => @chosen_api_versions, :'data-mode' => mode, :width => "420", :height => "300") do
      end
    end
  end
end
