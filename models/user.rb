require 'sinatra/activerecord'
require 'bcrypt'

class User < ActiveRecord::Base
  validates :login, presence: true , uniqueness: true
  validates :password, presence: true

  before_save :encrypt_password

protected
  def encrypt_password
    self.password = BCrypt::Password.create self.password
  end
end
