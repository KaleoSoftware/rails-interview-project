require 'spec_helper'
require 'rails_helper'
require 'pry'
RSpec.describe API::V1::QuestionsController, type: :controller do

  let(:question){build(:question)}
  let(:tenant){Tenant.first}
  let(:private_question){build(:question, private: true)}

  describe "Questions API" do
    fixtures :questions
    fixtures :answers
    fixtures :users
    fixtures :tenants
    render_views

    before :each do
      request.headers["accept"] = 'application/json'
    end

    it 'gets v1 of the api' do
      get :index, api_key: tenant.api_key
      expect(response).to have_http_status(:success)
    end

    it 'sends a list of questions' do
      get :index, api_key: tenant.api_key
      json = JSON.parse(response.body)
      # test for the 200 status-code
      expect(response).to be_success
      # check to make sure the right amount of questions are returned
      expect(json['questions'].count).to eq(2)
    end

    it 'retrieves a specific message' do
      question.save
      get :show, id: question, api_key: tenant.api_key
      # test for the 200 status-code
      expect(response).to be_success
      json = JSON.parse(response.body)
      # check that the message attributes are the same.
      expect(json['question']).to eq(question.as_json['title'])

      # ensure that private attributes aren't serialized
      expect(json['private_attr']).to eq(nil)
    end

    it "doesn't return a private record" do
      private_question.save
      get :index, api_key: tenant.api_key
      json = JSON.parse(response.body)
      # test for the 200 status-code
      expect(response).to be_success
      # check to make sure the right amount of questions are returned
      expect(json['questions'].count).to eq(2)
    end

    it 'gives answers in index' do
      get :index, formt: :json, api_key: tenant.api_key
      allow_any_instance_of(User).to receive(:name).and_return("BOB")
      json = JSON.parse(response.body)
      # test for the 200 status-code
      expect(response).to be_success
      # check to make sure the right amount of questions are returned
      expect(json['questions'].first['answers'].count).to eq(2)
    end

    it 'fails without an api key' do
      get :index, formt: :json, api_key: nil
      expect(response).not_to be_success
    end

    it 'increments Tenant#count on every call' do
      count = tenant.api_count
      get :index, formt: :json, api_key: tenant.api_key
      tenant.reload
      expect(count + 1).to eq(tenant.api_count)
    end

  end #describe

end
