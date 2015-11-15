
require 'sinatra/base'
require 'rack'
require 'bcrypt'
require 'sinatra/json'
require_relative '../models/provision.rb'
require_relative '../lib/config.rb'

class ProvisionsController < Sinatra::Base
  set :json_encoder, :to_json
  set :json_content_type, 'application/json;charset=utf-8'
  enable :logging

  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    auth = User.where(login: username).first
    true if username == auth.login and BCrypt::Password.new(auth.password).is_password? password
  end

  post '/' do
    @request_payload = JSON.parse request.body.read
   @os = OperatingSystem.find(@request_payload['operating_systems_id']).url if @request_payload['operating_systems_id']
   @host = OpenStruct.new(eval(HostConfig.find(@request_payload['host_configs_id']).settings)) if @request_payload['host_configs_id'] || OpenStruct.new
   @template = Template.find(@request_payload['templates_id']) if @request_payload['templates_id']
   if @request_payload['host_attributes']
     host_attributes = @host.to_h.merge(@request_payload['host_attributes'])
     @host = OpenStruct.new(host_attributes)
  end
   saved = erb @template.content
    @provision = Provision.new(content: saved)
      if @provision.save
        @ospxe = OperatingSystem.find(@request_payload['operating_systems_id'])
        label = "#{@ospxe.name.gsub(' ','_')}_#{@ospxe.major.to_s}_#{@ospxe.minor.to_s}"
         @kernel  = label + "/vmlinuz"
         @initrd  = label + "/initrd.img"
         @ks = "http://#{Config.general['hostname']}/ks=#{@provision.uuid}"
         mac = @request_payload['host'].gsub(':','-')
         File.open("/var/lib/tftpboot/pxelinux.cfg/01-#{mac}","w") do |f|
           f.write erb Template.find(15).content
         end

        json status: 200
      else
       json status: 400
      end
   end

private

  def generate_pxe_template(os)
    @ospxe = OperatingSystem.find(os)
    @kernel  = @os + "images/pxeboot/vmlinuz"
    @initrd  = @os.url + "images/pxeboot/initrd.img"
  end

end
