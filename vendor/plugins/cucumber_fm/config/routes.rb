Rails.application.routes.draw do
  namespace :documentation do
    get 'features/:id' => "features#show",
        :constraints => {:id => /.*[^(\/(edit|statistic))]/},
        :as => "feature_show"

    post 'features/:id' =>'features#update',
         :constraints => {:id => /.*[^(\/edit)]/},
         :as => "feature_update"

    resources :features do
      member do
        put :rename
        put :move
      end

      collection do
        get :statistic
      end
    end

    resource :kanban, :controller => 'kanban'
    match "assets/:path" => 'assets#get', :constraints => {:path => /.*/}
  end
end