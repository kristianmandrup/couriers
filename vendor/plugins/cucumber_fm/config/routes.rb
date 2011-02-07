Rails.application.routes.draw do
  namespace :documentation do
    get 'features/:id', :to => 'features#show', 
                        :constraints => { :id => /.*[^(\/(edit|statistic))]/},
                        :as => :feature_show

    post 'features/:id', :to => 'features#update', 
                         :constraints => { :id => /.*[^(\/edit)]/},
                         :as => :feature_update

    resources :features do
      collection do
        match "statistic"
      end
      member do
        match "rename"
        match "move"
        match "delete"
      end
    end
    resources :kanban, :except => :index

    get "assets/:path", :to => 'assets#get', :constraints => { :path => /.*/ }
    
  end
end