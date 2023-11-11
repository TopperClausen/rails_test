module V1
    class ProductsController < ApplicationController
        before_action :authorize
        
        def index
            success_response(data: Product.all)
        end
    end
end
