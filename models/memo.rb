# frozen_string_literal: true

require 'json'

class Memo
  attr_reader :id
  attr_accessor :title, :description

  def initialize(id, title, description)
    @id = id
    @title = title
    @description = description
  end

  def self.json_create(object)
    new(object['id'], object['title'], object['description'])
  end

  def as_json(*)
    {
      JSON.create_id => self.class.name,
      'id' => id,
      'title' => title,
      'description' => description
    }
  end

  def to_json(*)
    as_json.to_json
  end
end
