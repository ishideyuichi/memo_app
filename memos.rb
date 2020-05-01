# frozen_string_literal: true

require_relative 'storage'
require_relative 'memo'

# メモの一覧を保持し、操作するクラス
class Memos
  attr_accessor :all
  def initialize
    @all = Storage.new.select_all
  end

  def make_new(params)
    return if params[:title] == '' || params[:body] == ''

    id = @all == [] ? 1 : @all[@all.size - 1].id + 1
    memo = Memo.new(id: id, title: params[:title], body: params[:body])
    Storage.new.insert(memo)
  end
end
