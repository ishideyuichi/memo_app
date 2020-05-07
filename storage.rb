# frozen_string_literal: true

require_relative 'memo'
require 'pg'

# DBを操作するためのクラス
class Storage
  def initialize
    @connection = PG.connect(host: ENV['HOST'], user: ENV['USER'],
                             dbname: ENV['DB_NAME'],
                             password: ENV['DB_PASSWORD'])
  end

  def select_all
    connect('SELECT * FROM memos ORDER BY id').map do |row|
      Memo.new(id: row['id'].to_i, title: row['title'], body: row['body'])
    end
  end

  def select(params)
    row = connect('SELECT * FROM memos WHERE id = $1', [params['id']])[0]
    Memo.new(id: row['id'].to_i, title: row['title'], body: row['body'])
  end

  def insert(memo)
    query = 'INSERT INTO memos (title, body) VALUES ($1,$2)'
    connect(query, [memo.title, memo.body])
  end

  def delete(params)
    connect('DELETE FROM memos WHERE id = $1', [params['id'].to_i])
  end

  def update(params)
    query = 'UPDATE memos SET title = $2, body = $3 WHERE id = $1'
    connect(query, [params['id'].to_i, params[:title], params[:body]])
  end

  private

  def connect(query, params = nil)
    begin
      results = @connection.exec(query, params)
    ensure
      @connection.finish
    end
    results
  end
end
