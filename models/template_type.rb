require 'sinatra/activerecord'

class TemplateType < ActiveRecord::Base
  belongs_to :template
  validates :name, presence: true, uniqueness: true
end
