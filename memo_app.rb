# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require_relative 'helpers/memo_database_helper'

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

post '/memos' do
  title = params[:title]
  description = params[:description]
  MemoDatabaseHelper.create(title, description)
  redirect :memos
end
