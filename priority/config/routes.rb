resources :projects do
  resource :priorities, :only => [:update]
end
