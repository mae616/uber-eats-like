# フード一覧のAPIコントローラー
module Api
  module V1
    class FoodsController < ApplicationController
      def index
        # パラメーターに対応するデータを抽出する
        restaurant = Restaurant.find(params[:restaurant_id])
        # データを取得する
        foods = restaurant.foods

        render json: {
          foods: foods
        }, status: :ok
      end
    end
  end
end
