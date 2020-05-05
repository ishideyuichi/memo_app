# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require_relative 'memos'

# メモ一覧
get '/' do
  @memo_array = Memos.new.memos
  erb :index
end

# 新規メモの作成
post '/' do
  Memos.new.make_new(params)
  redirect to('/')
end

# 新規メモ作成画面
get '/new' do
  erb :new
end

# メモの閲覧
get '/:id' do
  @memo = Memos.new.find(params)
  erb :show
end

# メモの削除
delete '/:id' do
  Memos.new.delete(params)
  redirect to('/')
end

# メモの更新
patch '/:id' do
  Memos.new.update(params)
  redirect to('/')
end

# メモ編集フォーム
get '/edit/:id' do
  @memo = Memos.new.find(params)
  erb :edit
end
