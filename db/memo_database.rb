# frozen_string_literal: true

require 'securerandom'
require_relative '../models/memo'

# ファイルへのCRUDを行う
class MemoDatabase
  DATABASE_FILE_NAME = 'database'
  DATABASE_FILE_NAME.freeze

  MEMOS_KEY = :memo_list
  MEMOS_KEY.freeze

  def self.find(id)
    all.find { |memo| memo.id == id }
  end

  def self.all
    if load_file
      memo_hash_array = JSON.parse(load_file, { symbolize_names: true })[MEMOS_KEY]
      memo_hash_array.map { |memo_hash| Memo.new(memo_hash) }
    else
      []
    end
  end

  def self.create(title, description)
    memo_list = all
    memo = Memo.new(id: SecureRandom.uuid, title: title, description: description)
    memo_list.push(memo)
    save_file(memo_list)
  end

  def self.update(update_memo)
    updated_memo_list = all.map do |memo|
      if memo.id == update_memo.id
        update_memo
      else
        memo
      end
    end
    save_file(updated_memo_list)
  end

  def self.delete(id)
    save_file(all.delete_if { |memo| memo.id == id }) if find(id)
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
    if File.zero?(DATABASE_FILE_NAME)
      nil
    else
      JSON.load_file(DATABASE_FILE_NAME)
    end
  end
end
