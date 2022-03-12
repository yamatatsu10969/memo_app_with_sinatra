# frozen_string_literal: true

require 'securerandom'
require_relative '../models/memo'

# ファイルへのCRUDを行う
class MemoDatabase
  def self.initialize
    create_memo_table_if_needed
  end

  def self.create_memo_table_if_needed
    connection.exec('
      CREATE TABLE IF NOT EXISTS MEMO
      (id SERIAL PRIMARY KEY,
      title TEXT NOT NULL,
      description TEXT)
    ')
  end

  def self.connection
    PG.connect(dbname: 'memo_app')
  end

  def self.find(id)
    connection.exec('SELECT * FROM MEMO WHERE id = $1', [id]) do |result|
      Memo.new(result.first)
    end
  end

  def self.all
    connection.exec('SELECT * FROM MEMO') do |result|
      result.map do |memo|
        Memo.new(memo)
      end
    end
  end

  def self.create(title, description)
    connection.exec('INSERT INTO MEMO (title, description) VALUES ($1, $2)', [title, description])
  end

  def self.update(update_memo)
    connection.exec('UPDATE MEMO SET title = $1, description = $2 WHERE id = $3', [update_memo.title, update_memo.description, update_memo.id])
  end

  def self.delete(id)
    connection.exec('DELETE FROM MEMO WHERE id = $1', [id])
  end
end
