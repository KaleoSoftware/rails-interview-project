# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Questions API', type: :request do
  before do
    @public_question = create(:question, private_question: false)
    @private_question = create(:question, private_question: true)
    @tenant = create(:tenant)
    @request_count = @tenant.request_count
    @api_key = @tenant.api_key
  end

  let!(:answers) { create_list(:answer, 10) }

  # Test suite for GET /questions without api_key
  describe 'GET /questions' do
    # make HTTP get request before each example
    before { get '/questions' }

    it 'returns error json' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
      expect(json['error']).not_to be_nil
      expect(json['status']).not_to be_nil
    end

    it 'returns status code 400' do
      expect(response).to have_http_status(400)
    end
  end

  # Test suite for GET /questions with invalid api_key
  describe 'GET /questions with invalid api_key' do
    # make HTTP get request before each example
    before { get '/questions?api_key=invalid' }

    it 'returns failure json' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
      expect(json['error']).not_to be_nil
      expect(json['status']).not_to be_nil
    end

    it 'returns status code 401' do
      expect(response).to have_http_status(401)
    end
  end

  # Test suite for GET /questions with valid api_key
  describe 'GET /questions with api_key' do
    # make HTTP get request before each example
    before { get "/questions?api_key=#{@api_key}" }

    it 'returns questions json' do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'increments the request_count' do
      tenant = Tenant.find_by(id: @tenant.id)
      expect(tenant.request_count).to eq(@request_count + 1)
    end

    it 'expects the json to include questions' do
      expect(json.first[0]).to eq('questions')
    end

    it 'expects questions to have an id, asker details, and questions' do
      expect(json['questions'][0]).to include('id', 'question', 'asker_id', 'asker_name')
    end

    it 'includes an answer with id, answer, and answerer details' do
      expect(json['questions'][1]['answers'][0]).to include('id', 'answer', 'answerer_id', 'answerer_name')
    end

    it 'does return public questions' do
      expect(json['questions'][0]).to include('id' => @public_question.id)
    end

    it "doesn't return private questions" do
      expect(json['questions'][1]).not_to include('id' => @private_question.id)
    end
  end

  # Test suite for GET /questions with valid api_key and search key
  describe 'GET /questions with api_key' do
    # make HTTP get request before each example
    before do
      @public_question_dog = create(:question, private_question: false, title: 'good dog?')
      @private_question_dog = create(:question, private_question: true, title: 'good dog?')
      get "/questions?api_key=#{@api_key}&search=dog"
    end

    it 'returns questions json' do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'increments the request_count' do
      tenant = Tenant.find_by(id: @tenant.id)
      expect(tenant.request_count).to eq(@request_count + 1)
    end

    it 'expects the json to include questions' do
      expect(json.first[0]).to eq('questions')
    end

    it 'does return questions with dog in title' do
      expect(json['questions'][0]['question']).to include('dog')
    end
  end

  # Test suite for GET /questions with valid api_key and no search results
  describe 'GET /questions with api_key' do
    # make HTTP get request before each example
    impossible_string = 'thisisastringthatwouldneverpossiblybegeneratednaturally'
    before do
      @public_question_dog = create(:question, private_question: false, title: 'good dog?')
      @private_question_dog = create(:question, private_question: true, title: 'good dog?')
      get "/questions?api_key=#{@api_key}&search=#{impossible_string}"
    end

    it 'returns questions json' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end

    it 'increments the request_count' do
      tenant = Tenant.find_by(id: @tenant.id)
      expect(tenant.request_count).to eq(@request_count + 1)
    end
  end
end
