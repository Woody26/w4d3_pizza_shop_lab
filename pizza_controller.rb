require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative("./models/pizza_order")
also_reload("./models/*")

#INDEX ROUTE (R in CRUD)
get "/pizza-orders" do
  @orders = PizzaOrder.all()
  erb(:index)
end

#NEW CREATE (C in CRUD) MUST go above show route due to
# clash with path (it would stop if it hit the one underneath
#first)
get "/pizza-orders/new" do
  erb(:new)
end

#POST REQUEST
post "/pizza-orders" do
  @order = PizzaOrder.new(params)
  @order.save()
  erb(:create)
end

#SHOW ROUTE (R in CRUD)
#Once submitted order, all info goes into the params hash
get "/pizza-orders/:id" do
  @order = PizzaOrder.find( params["id"] )
  erb(:show)
  #for every erb you need a corresponding file in views folder
end

#DESTROY/DELETE REQUEST (D in CRUD)
post "/pizza-orders/:id/delete" do
  @order = PizzaOrder.find( params["id"] )
  @order.delete()
  erb(:delete_acknowledge)
end

#EDIT
get "/pizza-orders/:id/edit" do
  @order = PizzaOrder.find( params["id"] )
  erb(:edit)
end

#UPDATE
# post "/pizza-orders/:id" do
#   @order = PizzaOrder.find( params["id"] )
#   @order.update()
#   erb(:show)
# end
