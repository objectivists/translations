Rails.application.routes.draw do

  get 'admin' => 'admin#index'

  scope '/admin' do
    resources :books
    resources :languages
    resources :translations
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
