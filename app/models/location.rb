class Location < ActiveRecord::Base
  belongs_to :facility

  attr_accessor :distance
end
