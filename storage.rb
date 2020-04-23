# frozen_string_literal: true

require 'yaml/store'

# メモを保存しているファイルに読み書きするクラス
class Storage
  def initialize
    @store = YAML::Store.new 'memos.yml'
  end

  def make_memos
    @store.transaction { @store['memos'] }
  end

  def save_memos(memos)
    @store.transaction { @store['memos'] = memos }
  end
end

