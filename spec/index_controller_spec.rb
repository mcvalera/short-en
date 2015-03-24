require_relative 'spec_helper'

describe 'index controller test' do

  describe 'get /' do
    it 'renders a successful page' do
      get '/'
      expect(last_response.status).to eq(200)
    end

  end

end


  #   it 'displays an article' do
  #     #arrange
  #     Article.create(title: "Hi Squirrels")
  #     #act
  #     get '/articles'
  #     #assert
  #     expect(last_response.body).to include("Hi Squirrels!")
  #   end
  # end

  # describe 'POST /articles' do
  #   it 'create a new article' do
  #     #Article.delete_all
  #     expect {
  #       post '/articles', title: "That's not cool"
  #     }.to change {Article.count}
  #   end