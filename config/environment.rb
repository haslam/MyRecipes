# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

#Add the below line to include CarrierWave ActiveRecord
require 'carrierwave/orm/activerecord'