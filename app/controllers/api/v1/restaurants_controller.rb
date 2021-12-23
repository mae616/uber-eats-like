# 店舗一覧を返すAPIコントローラー
module Api # 名前空間の定義 ディレクトリと合わせる
  module V1
    class RestaurantsController < ApplicationController
      def index
        # Restaurantモデルを全て取得して代入
        restaurants = Restaurant.all

        # 200 OKと一緒にJSON形式でデータを返却
        render json: {
          restaurants: restaurants
        }, status: :ok
      end
    end
  end
end
