# frozen_string_literal: true

require_relative 'storage.rb'
require_relative 'memo.rb'

# メモの一覧を保持し、操作するクラス
class Memos
  attr_accessor :memos
  def initialize
    @memos = Storage.new.make_memos
  end

  def make_new(params)
    return if params[:title] == '' || params[:body] == ''

    memo = Memo.new(title: params[:title], body: params[:body])
    @memos && @memos != [] ? add(memo) : @memos = [memo]
    save
  end

  def find(params)
    @memos.find { |memo| memo.id == fetch_id(params) }
  end

  def delete(params)
    @memos.delete_at(find_memo_id(params))
    save
  end

  def update(params)
    id = find_memo_id(params)
    @memos[id].title = params[:title]
    @memos[id].body = params[:body]
    save
  end

  private

  def add(memo)
    memo.id = @memos[@memos.size - 1].id + 1
    @memos.push(memo)
  end

  def fetch_id(params)
    params['id'].to_i
  end

  def find_memo_id(params)
    @memos.find_index { |memo| memo.id == fetch_id(params) }
  end

  def save
    Storage.new.save_memos(@memos)
  end
end
