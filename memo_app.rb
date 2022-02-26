# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'

get '/memos' do
  erb :memos
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  id = params[:id]
  erb :memo
end

get '/memos/:id/edit' do
  id = params[:id]
  erb :edit
end
