class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top] # 全画面でログインを必須とする処理（require_login）をtopアクションだけ除外
  def top;end
end
