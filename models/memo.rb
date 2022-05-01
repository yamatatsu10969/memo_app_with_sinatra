# frozen_string_literal: true

require 'json'

class Memo
  attr_reader :id, :title, :description

  def initialize(args = {})
    @id = args['id']
    @title = args['title']
    @description = args['description']
  end
end
