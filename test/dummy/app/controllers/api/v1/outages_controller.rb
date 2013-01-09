class Api::V1::OutagesController < ApplicationController
  before_filter :my_filter
  
  
  def my_filter
    p ">>>> Mine mine!"
  end
end
