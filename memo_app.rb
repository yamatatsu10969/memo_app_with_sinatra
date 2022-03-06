# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'erubi'
require_relative 'db/memo_database'

set :erb, escape_html: true

get '/memos' do
  @memos = MemoDatabase.all
  erb :memos
end

post '/memos' do
  title = params[:title]
  description = params[:description]
  MemoDatabase.create(title, description)
  redirect :memos
end

get '/memos/new' do
  erb :new
end

get '/memos/:id' do
  id = params[:id]
  @memo = MemoDatabase.find(id)
  pass if @memo.nil?
  erb :memo
end

get '/memos/:id/edit' do
  id = params[:id]
  @memo = MemoDatabase.find(id)
  pass if @memo.nil?
  erb :edit
end

# 404
get '/*' do
  erb :not_found
end

patch '/memos/:id' do
  id = params[:id]
  @memo = MemoDatabase.find(id)
  redirect :not_found if @memo.nil?

  title = params[:title]
  description = params[:description]
  memo = Memo.new(id: id, title: title, description: description)
  MemoDatabase.update(memo)
  redirect :memos
end

delete '/memos/:id' do
  id = params[:id]
  MemoDatabase.delete(id)
  redirect :memos
end
