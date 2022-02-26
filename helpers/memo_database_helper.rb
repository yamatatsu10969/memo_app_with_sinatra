# frozen_string_literal: true

require 'securerandom'
require_relative '../models/memo'

# ファイルへのCRUDを行う
class MemoDatabaseHelper
  DATABASE_FILE_NAME = 'database'
  DATABASE_FILE_NAME.freeze

  MEMOS_KEY = 'memo_list'
  MEMOS_KEY.freeze

  def self.memo(id)
    memo_all.find { |memo| memo.id == id }
  end

  def self.memo_all
    memo_hash_array = JSON.parse(load_file)[MEMOS_KEY]
    if memo_hash_array.nil?
      []
    else
      memo_hash_array.map { |memo_hash| Memo.json_create(memo_hash) }
    end
  end

  def self.create(title, description)
    memo_list = memo_all
    memo = Memo.new(SecureRandom.uuid, title, description)
    memo_list.push(memo)
    save_file(memo_list)
  end

  def self.update(update_memo)
    updated_memo_list = memo_all.map do |memo|
      if memo.id == update_memo.id
        update_memo
      else
        memo
      end
    end
    save_file(updated_memo_list)
  end

  def self.delete(id)
    save_file(memo_all.delete_if { |memo| memo.id == id }) if memo(id)
  end

  def self.save_file(memo_list)
    json = {
      "#{MEMOS_KEY}": memo_list
    }.to_json
    File.open(DATABASE_FILE_NAME, 'w') do |file|
      JSON.dump(json, file)
    end
  end

  def self.load_file
    JSON.load_file(DATABASE_FILE_NAME)
  end
end
