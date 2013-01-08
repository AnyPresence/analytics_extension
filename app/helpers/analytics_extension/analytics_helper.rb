module AnalyticsExtension
  module AnalyticsHelper
    def chart_tag(params = {})
      params[:format] ||= :json
      path = statistics_path(params)
      content_tag(:div, :id => 'visualization', :'data-chart' => path, :style => "height: 300px;") do
        #image_tag('spinner.gif', :size => '24x24', :class => 'spinner')
      end
    end
  end
end
