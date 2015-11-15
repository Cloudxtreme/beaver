require 'sinatra/base'
require 'sinatra/namespace'
require 'sinatra/activerecord'
require 'sinatra/json'
require_relative '../models/template.rb'

class TemplatesController < Sinatra::Base
  set :json_encoder, :to_json
  set :json_content_type, 'application/json;charset=utf-8'

  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    auth = User.where(login: username).first
    true if username == auth.login and BCrypt::Password.new(auth.password).is_password? password
  end

  TMP_PATH = '/tmp/'

  get('/') { json Template.all.select('id,name,template_types_id')}

  get  '/:id' do
    content_type 'text/plain'
    Template.find(params[:id]).content
  end

  post '/'  do
    @filename = "#{params[:file][:filename]}_#{Time.now.strftime("%Y%m%dT%H%M%S")}_#{request.env['REMOTE_USER']}"
      File.open("#{TMP_PATH}#{@filename}", 'w') {|f| f.write( params[:file][:tempfile].read)}
      unless `file -b --mime-type #{TMP_PATH}#{@filename}`.chomp != 'text/plain'
        template = File.read("#{TMP_PATH}#{@filename}")
        @template = Template.new(name: params[:name], template_types_id: params[:template_types_id], content: template.chomp)
        File.delete("#{TMP_PATH}#{@filename}")
          if @template.save
            json status: 200
          else
            json status: 400
          end
      end
  end

  patch '/:id' do
    logger.info params.inspect
      @template = Template.find(params[:id])
      params.delete("splat"); params.delete("captures")
       if @template.update_attributes(params)
         json status: 200
       else
         json status: 400
       end
  end

  delete '/:id' do
      @template = Template.find(params[:id])
      if @template.destroy
        json status: 200
      else
        json status: 400
    end
  end
end
