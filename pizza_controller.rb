require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative('./models/pizza_order')
also_reload('./models/*') #useful for runninng server

# INDEX disply all pizzas
get '/pizza-orders' do
  @orders = PizzaOrder.all()
  erb( :index )
end

# NEW display a form to make a new pizaa order
#order in which your code is organised!!(hits new then params)
#created form, input name must equal class parameter name.
get '/pizza-orders/new' do
  erb( :new )
end



# UPDATE amend a db entry for the edited pizza order
post '/pizza-orders/:id/update' do
  order = PizzaOrder.find(params[:id])
  #binding.pry
  order.change_first(params[:first_name])
  order.change_last(params[:last_name])
  order.new_topping(params[:topping])
  order.new_quantity(params[:quantity])
  @updated = order.update()
  redirect '/pizza-orders'
end

# SHOW display one
get '/pizza-orders/:id' do
  @order = PizzaOrder.find(params[:id])
  erb( :show )
end

# CREATE make a new db entry for a pizza order
post '/pizza-orders' do
  @order = PizzaOrder.new(params)
  @order.save()
  erb( :create )
end

# DELETE remove a pizza order from the database.
post '/pizza-orders/:id/delete' do
  pizza_id = params[:id]
  @pizza_find = PizzaOrder.find(pizza_id)
  @pizza_find.delete()
  erb( :delete )
  redirect '/pizza-orders'
end

# EDIT display a form to edit a pizza order details
get '/pizza-orders/:id/update' do
  @pizza_find = PizzaOrder.find(params[:id])
  erb( :update )
end
