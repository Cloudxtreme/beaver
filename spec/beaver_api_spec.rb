require_relative 'spec_helper.rb'

describe "API V1" do

  it "requires authentication" do
    get '/'
    last_response.status.must_equal 401
  end

  it "only accepts valid credentials" do
    authorize 'admin','wrongpass'
    get '/'
    last_response.status.must_equal 401
  end

  it "should successfully return a greeting" do
    authorize 'admin', 'admin'
    get '/'
    last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'
    last_response.body.must_include 'Augello Christophe'
  end

#  it "should return a service status" do
#    authorize 'admin', 'admin'
#    get '/status'
  #  last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'
  #  last_response.body.must_include 'status'
#    last_response.body.must_include 'tftp'
  #  last_response.body.must_include 'postgres'
#  end

end

describe "GET /users" do
  before(:each) do
    authorize 'admin','admin'
    get '/users'
  end

  it "should return a json response" do
    last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'
  end

  it "should have at least 1 user" do
    last_response.body.must_include 'admin'
  end

end

describe "POST /users" do

  before(:each) do
    begin
      User.where(login: 'testuser').first.destroy
    rescue
    end
    authorize 'admin','admin'
    params = {login: 'testuser', password: 'testpass'}
    post '/users', params.to_json
  end

    it "should return a json response" do
      last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'
    end

    it "should return status 200 on success" do
      last_response.body.must_equal "{\"status\":200}"
    end
end

describe "PATCH /users/:id" do
  before(:each) do
    authorize 'admin','admin'
    user = User.where(login: 'testuser').first
    params = {login: 'testuser', password: 'newpass'}
    patch "/users/#{user.id}", params.to_json
  end

  it "should return a json response" do
    last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'
  end

  it "should return status 200 on success" do
    last_response.body.must_equal "{\"status\":200}"
  end
end

#describe "DELETE /users/:id" do
#  it "should delete the user" do
#    authorize 'admin','admin'
    #user = User.where(login: 'testuser').first
    #delete "/users/#{user.id}"
    #last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'
    #last_response.body.must_equal "{\"status\":200}"
  #end
#end

describe "GET /template_types" do
  it "should return the available tempate types" do
    authorize 'admin','admin'
    get '/template_types'
    last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'
    last_response.body.must_include 'pxe'
  end
end

describe "POST /templates" do
  it "should create a template" do
      authorize 'admin','admin'
      params = {name: 'testfile', type: 'kickstart', file: Rack::Test::UploadedFile.new('/home/kartouch/Dev/Beaver/spec/anaconda-ks.cfg', 'text/plain')}
      post '/templates', params.to_json
      Dir['tmp/*'].must_include('tmp/anaconda-ks.cfg')
      last_response.headers['Content-Type'].must_equal 'application/json;charset=utf-8'
      last_response.body.must_equal "{\"status\":200}"
    end
end

#    describe "GET /templates" do
#end

#  describe "GET /templates/:id"

#  describe "PATCH /templates/:id"
#  describe "DELETE /templates/:id"
