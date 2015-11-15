require 'sinatra/activerecord'
require 'securerandom'

class Provision < ActiveRecord::Base
  #validates :uuid, presence: true , uniqueness: true
  validates :content, presence: true

  before_save :generate_uuid

protected
  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
