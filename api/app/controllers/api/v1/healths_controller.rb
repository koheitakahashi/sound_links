# frozen_string_literal: true

module API
  module V1
    # NOTE: AWS ELB のヘルスチェック用の controller。Searches#indexは独自ヘッダをリクエストに含めないと401を返すため、ヘルスチェックが失敗する。
    #   ゆえに、ヘルスチェック用のcontrollerを作成。
    class HealthsController < ApplicationController
      def index
        render json: { message: 'Health check is successfully' }, status: :ok
      end
    end
  end
end
