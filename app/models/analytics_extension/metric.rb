module AnalyticsExtension
  class Metric
    include ActiveModel::MassAssignmentSecurity
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :name, type: String
    field :description, type: String
    field :value, type: Hash
    field :independent_values, type: Array
    field :dependent_values, type: Array
    
    
  end
end