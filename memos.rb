# frozen_string_literal: true

require './storage.rb'

# メモの一覧を保持し、操作するクラス
class Memos
  attr_accessor :memos
  def initialize
    @memos = Storage.new.make_memos
  end

  def make_new_memo(params)
    return if params[:title] == '' || params[:body] == ''

    memo = { title: params[:title], body: params[:body] }
    @memos && @memos != [] ? add_memo(memo) : initialize_memos(memo)
    save_memos
  end

  def find_memo(params)
    @memos.find { |h| h[:id] == fetch_id(params) }
  end

  def delete_memo(params)
    @memos.delete_at(find_memo_id(params))
    save_memos
  end

  def update_memo(params)
    id = find_memo_id(params)
    @memos[id][:title] = params[:title]
    @memos[id][:body] = params[:body]
    save_memos
  end

  private

  def add_memo(memo)
    memo[:id] = @memos[@memos.size - 1][:id] + 1
    @memos.push(memo)
  end

  def initialize_memos(memo)
    memo[:id] = 1
    @memos = [memo]
  end

  def fetch_id(params)
    params['id'].to_i
  end

  def find_memo_id(params)
    @memos.find_index { |h| h[:id] == fetch_id(params) }
  end

  def save_memos
    Storage.new.save_memos(@memos)
  end
end
