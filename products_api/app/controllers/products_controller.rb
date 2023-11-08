class ProductsController < ApplicationController
    before_action :authorize
    
    def index
        render json: Product.all
    end
end
