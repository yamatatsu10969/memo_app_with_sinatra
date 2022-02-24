# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'

get '/' do
  # 'hello'
  'good bye!!!!!!!'
end

get '/path/to' do
  'this is [/path/to]'
end
