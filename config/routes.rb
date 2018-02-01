Rails.application.routes.draw do
  #scope "(:locale)", locale: /en|vi/ do
    resources :restaurants
    root to: "restaurants#index"
  #end
end
