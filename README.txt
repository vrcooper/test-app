== README

The client and server side pages required to run the braintree integration are:

routes.rb

I've included application.example.yml since application.yml has sensitive date. Please substitute your own API key values for BT

application.yml 

app/controllers/checkouts_controller.rb
app/controllers/orders_controller.rb

app/views/checkout/new.html.erb

views/orders/checkout.html.erb

views/devise/registrations/edit.html.erb

views/layouts/application.html.erb

app/config/initializers/braintree.rb

Gemfile

Click on the email address link next to Hello at the top of the page in the nav bar area, for example: Hello janed@example.com

This link will lead you to the users/edit page where you can upgrade your account to premium under the Manage my account heading. Click the Upgrade to Premium button to make payment via Braintree API.