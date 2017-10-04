Rails.application.routes.draw do
  # The routes for the home and help actions in the Static Pages controller
  get "static_pages/home"
  get "static_pages/help"
  get  "static_pages/about"
  get  "static_pages/contact"

  # Setting the root route
  root "static_pages#home"
end
