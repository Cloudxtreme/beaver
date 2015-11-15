require 'sinatra/activerecord'

class HostConfig < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :settings, presence: true
end
