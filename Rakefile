require "sinatra/activerecord/rake"
require 'bcrypt'
require_relative './models/user.rb'

namespace :db do
    task :load_config do
          require "./beaver_api"
          end
end

task :default do
  system "rake --tasks"
end

namespace :setup do
  desc "Setup the admin account or reset the password"
  task :credentials do
    pwd = SecureRandom.hex
    hashed = BCrypt::Password.create pwd
    unless User.where(login: 'admin').nil?
      User.create(login: 'admin', password: hashed)
    else
      user = User.where(login: 'admin').first
      user.password = hashed
      user.save
    end
    puts "==================================="
    puts "Credentials:"
    puts "login: admin"
    puts "password: #{pwd}"
    puts "==================================="
  end
end
