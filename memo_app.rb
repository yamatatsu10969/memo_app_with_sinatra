# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require_relative 'db/memo_database'

get '/memos' do
  @memos = MemoDatabase.all
  erb :memos
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  id = params[:id]
  @memo = MemoDatabase.find(id)
  erb :memo
end

get '/memos/:id/edit' do
  id = params[:id]
  @memo = MemoDatabase.find(id)
  erb :edit
end

post '/memos' do
  title = params[:title]
  description = params[:description]
  MemoDatabase.create(title, description)
  redirect :memos
end

patch '/memos/:id' do
  id = params[:id]
  title = params[:title]
  description = params[:description]
  memo = Memo.new(id, title, description)
  MemoDatabase.update(memo)
  redirect :memos
end

delete '/memos/:id' do
  id = params[:id]
  MemoDatabase.delete(id)
  redirect :memos
end
