class ApplicationController < ActionController::API
  # ローディングを表示するため遅くする
  before_action :fake_load

  def fake_load
    sleep(1)
  end
end
