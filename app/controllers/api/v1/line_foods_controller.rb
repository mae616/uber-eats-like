module Api
  module V1
    class LineFoodsController < ApplicationController
      before_action :set_food, only: %i[create]

      def create
        # 他店舗でアクティブなLineFoodが存在するか(例外パターン)
        if LineFood.active.other_restarant(@ordered_food.restaurant.id).exists?
          return render json: {
            existing_restaurant: LineFood.other_restaurant(@ordered_food.restaurant.id).first.restaurant.name,
            new_restaurant: Food.fine(parama[:food_id]).restaurant.name,
          }, status: :not_acceptable # 406 Not Acceptable
        end

        # line_foodインスタンスを生成する
        set_line_food(@ordered_food)

        # DBに保存する
        if @line_food.save
          render json: {
            line_food: @line_food
          }, status :created
        else
          # HTTPレスポンスステータスコードが500系
          render json: {}, status :internal_server_error
        end
      end

      private

      def set_food
        @ordered_food = Food.fine(params[:food_id])
      end

      # line_foodインスタンスを生成する
      def set_line_food(ordered_food)
        if ordered_food.line_food.present?
          # 既存のline_foodインスタンスの既存の情報を更新
          @line_food = ordered_food.line_food
          @line_food.attributes ={
            count: ordered_food.line_food.count + params[:count],
            active: true
          }
        else
          # インスタンスを新規作成
          @line_food = ordered_food.build_line_food(
            count: params[:count]
            restaurant: ordered_food.restaurant,
            active: true
          )
        end
      end
    end
  end
end
