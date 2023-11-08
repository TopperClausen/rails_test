user = User.create(email: 'admin@test.dk', password: 'ChangeMe1337', full_name: 'Super Admin')
shoe = Product.create(name: 'Shoe', description: 'A very nice shoe in hight quality', price: 60)
jacket = Product.create(name: 'Jacket', description: 'A very nice jacket in hight quality', price: 120)

user.basket.push(shoe)
shoe_relation = BasketProduct.find_by(product_id: shoe.id)
shoe_relation.amount = 2
shoe_relation.save!
user.basket.push(jacket)
jacket_relation = BasketProduct.find_by(product_id: jacket.id)
jacket_relation.amount = 0
jacket_relation.save!

user.save!