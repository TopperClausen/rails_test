FactoryGirl.define do
    factory :user do
        sequence(:email) { |n| "test#{n}@test.dk" }
        password 'ChangeMe1337'
        full_name 'Test Testesen'

        trait :with_basket do
            after(:create) do |user|
                product = create(:product)
                user.basket.push(product)
                relation = user.basket_product.find_by(product_id: product.id);
                relation.amount = 1
                relation.save!
            end
        end

        trait :with_order do
            after(:create) do |user|
                order = create(:order, user_id: user.id)
                create(:product).to_ordered_product!(order_id: order.id)
            end
        end
    end

    factory :product do
        sequence(:name) { |n| "Test product #{n}"}
        description 'A very nice test product'
        price 40
    end

    factory :order do
    end

    factory :ordered_product do
        baught_price 69
    end
end