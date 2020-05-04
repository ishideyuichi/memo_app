# frozen_string_literal: true

require_relative 'storage'
require_relative 'memo'

# メモの一覧を保持し、操作するクラス
class Memos
  attr_accessor :memos
  def initialize
    @memos = Storage.new.select_all
  end

  def make_new(params)
    return if params[:title] == '' || params[:body] == ''

    id = @all == [] ? 1 : @memos[@memos.size - 1].id + 1
    memo = Memo.new(id: id, title: params[:title], body: params[:body])
    Storage.new.insert(memo)
  end

  def find(params)
    Storage.new.select(params)
  end

  def delete(params)
    Storage.new.delete(params)
  end

  def update(params)
    Storage.new.update(params)
  end
end
