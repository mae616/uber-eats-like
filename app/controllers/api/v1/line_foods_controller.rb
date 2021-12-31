module Api
  module V1
    class LineFoodsController < ApplicationController
      before_action :set_food, only: %i[create replace]

      # 仮注文の一覧
      def index
        line_foods = LineFood.active
        #exists...対象のインスタンスのデータがDBに存在するかどうか？をtrue/falseで返すメソッド
        if line_foods.exists?
          render json: {
            line_food_ids: line_foods.map{|line_food| line__food.id},
            restaurant: lind_foods[0].restaurant,
            count: line_foods.sum{|line_food| line_food[:count]},
            amount: line_foods.sum{|line_food| line_food.total_amount}
          }, status: :ok
        else
          # 204
          render json: {}, status: :no_content
        end
      end

      # 仮注文の作成
      def create
        # 他店舗でアクティブなLineFoodが存在するか(例外パターン)
        if LineFood.active.other_restaurant(@ordered_food.restaurant.id).exists?
          return render json: {
            existing_restaurant: LineFood.other_restaurant(@ordered_food.restaurant.id).first.restaurant.name,
            new_restaurant: Food.find(params[:food_id]).restaurant.name,
          }, status: :not_acceptable # 406 Not Acceptable
        end

        # line_foodインスタンスを生成する
        set_line_food(@ordered_food)

        # DBに保存する
        if @line_food.save
          render json: {
            line_food: @line_food
          }, status: :created
        else
          # HTTPレスポンスステータスコードが500系
          render json: {}, status: :internal_server_error
        end
      end

      # 例外ケース（古い仮注文を論理削除し、新しいデータを作成する）
      def replace
        # 論理削除
        LineFood.active.other_restaurant(@ordered_food.restaurant.id).each do |line_food|
          line_food.update_attribute(:active, false)
        end

        # @line_foodの生成
        set_line_food(@ordered_food)

        # 保存
        if @line_food.save
          render json: {
            line_food: @line_food
          }, status: :created
        else
          render json: {}, status: :internal_server_error
        end
      end

      private

      def set_food
        @ordered_food = Food.find(params[:food_id])
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
            count: params[:count],
            restaurant: ordered_food.restaurant,
            active: true
          )
        end
      end
    end
  end
end
