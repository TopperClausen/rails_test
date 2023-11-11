module V1
    class BasketsController < ApplicationController
        before_action :authorize

        def show
            basket_product = @user.basket_product.where.not(amount: 0).includes(:product)
            products_with_amount = basket_product.map { |scoped_basket_products| { amount: scoped_basket_products.amount, product: scoped_basket_products.product } }
            success_response(data: products_with_amount)
        end

        def update
            existing_product_relation = @user.basket_product.find_by(product_id: params[:product_id])
            if existing_product_relation.blank?
                BasketProduct.create(user_id: @user_id, product_id: params[:amount])
            else
                existing_product_relation.amount = params[:amount]
                existing_product_relation.save!
            end

            @user.reload
            basket_product = @user.basket_product.where.not(amount: 0).includes(:product)
            products_with_amount = basket_product.map { |scoped_basket_products| { amount: scoped_basket_products.amount, product: scoped_basket_products.product } }
            success_response(data: products_with_amount)
        end

        def destroy
            @user.basket.destroy_all
            success_response
        end
    end
end
