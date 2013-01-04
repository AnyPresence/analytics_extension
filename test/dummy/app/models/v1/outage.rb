class V1::Outage
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :"title", type: String
  
end