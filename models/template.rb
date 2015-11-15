require 'sinatra/activerecord'

class Template < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :content, presence: true
  validates :template_types_id,  presence: true
end
