module V1
    class OrdersController < ApplicationController
        before_action :authorize

        def index
            success_response(data: @user.orders.includes(:ordered_products).as_json(include: { ordered_products: {} }))
        end

        def show
            orders = @user.orders.where(id: params[:id]).includes(:ordered_products);
            if orders.blank?
                not_found_response
            else
                success_response(data: orders.first.as_json(include: { ordered_products: {} }))
            end
        end

        def create
            return bad_request_response(message: 'No products in basket') if @user.basket.empty?

            order = Order.create!(user_id: @user.id)
            @user.basket.each { |product| product.to_ordered_product!(order_id: order.id) }
            @user.basket.destroy_all
            success_response(data: order)
        rescue StandardError => e
            puts e.message
            server_error_response
        end
    end
end
