require 'spec_helper'
require 'rack/test'
require 'grape-entity'
require 'grape/msgpack'

class MockModel
  def initialize(name, age)
    @name = name
    @age = age
  end
  attr_reader :name, :age
end

class MockEntity < Grape::Entity
  expose :name
end

class MockAPI < Grape::API
  rescue_from :all

  default_format :msgpack

  get :test do
    [1, 2, 3]
  end

  get :model do
    present MockModel.new('test_user', 21), with: MockEntity
  end

  get :models do
    present [MockModel.new('test_user', 21)], with: MockEntity
  end

  get :exception do
    raise StandardError, 'an error occurred'
  end

  params do
    requires :name, type: String
  end
  post :input do
    present name: params.name
  end
end

describe MockAPI do
  include Rack::Test::Methods

  def app
    MockAPI
  end

  describe 'GET /test' do
    subject(:response) do
      get '/test'
      last_response
    end

    it { expect(response.status).to eq(200) }
    it { expect(response.headers['Content-Type']).to eq('application/x-msgpack') }
    it { expect(MessagePack.unpack(response.body)).to eq([1, 2, 3]) }
  end

  describe 'GET /model' do
    subject(:response) do
      get '/model'
      last_response
    end

    it { expect(response.status).to eq(200) }
    it { expect(response.headers['Content-Type']).to eq('application/x-msgpack') }
    it { expect(MessagePack.unpack(response.body)).to eq('name' => 'test_user') }
  end

  describe 'GET /models' do
    subject(:response) do
      get '/models'
      last_response
    end

    it { expect(response.status).to eq(200) }
    it { expect(response.headers['Content-Type']).to eq('application/x-msgpack') }
    it { expect(MessagePack.unpack(response.body).first).to eq('name' => 'test_user') }
  end

  describe 'GET /exception' do
    subject(:response) do
      get '/exception'
      last_response
    end

    it { expect(response.status).to eq(500) }
    it { expect(response.headers['Content-Type']).to eq('application/x-msgpack') }
    it { expect(MessagePack.unpack(response.body)).to eq('error' => 'an error occurred') }
  end

  describe 'POST /input' do
    subject(:response) do
      header 'Content-Type', 'application/x-msgpack'
      post '/input', { name: 'joe' }.to_msgpack
      last_response
    end

    it { expect(response.status).to eq 201 }
    it { expect(response.headers['Content-Type']).to eq('application/x-msgpack') }
    it { expect(MessagePack.unpack(response.body)).to eq('name' => 'joe') }
  end
end
