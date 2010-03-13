ActionController::Routing::Routes.draw do |map|

  map.namespace :management do |management|
    management.resources :statistics, :collection => { :search => :get, :subscribers => :get }
    management.resources :articles do |article|
      article.resources :comments, :member => { :approve => :get, :unapprove => :get }
    end
    management.connect '/pages/filter/:filter', :controller => 'pages', :action => 'filter'
    management.resources :pages, :member => { :subpage => :get, :revert_to_version => :get }, :collection => { :search => :get, :search_tags => :get, :tag_show => :get }
    
    management.resources :users, :member => { :suspend => :put, :unsuspend => :put, :purge => :delete } do |user|
      user.resources :roles
    end
    management.root :controller => 'sessions', :action => 'new'
    management.resource :session
    management.logout '/logout', :controller => 'sessions', :action => 'destroy'
    management.login  '/login', :controller => 'sessions', :action => 'new'
    management.activate        '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
    management.forgot_password '/forgot_password',      :controller => 'passwords', :action => 'new'
    management.reset_password  '/reset_password/:id',  :controller => 'passwords', :action => 'edit'
  end
  
  
  
  map.with_options(:controller => 'site') do |site|
    site.connect '/blog/:year/:month/:day', :month => nil, :day => nil, :requirements => { :year => /\d{4}/ }
    site.connect '/blog/:permalink', :action => 'article_show'
    site.connect '/blog/:permalink/comment', :action => 'create_comment'
    site.connect '/blog', :action => 'articles_index'
    site.connect '/feed/rss/', :action => 'articles_feed', :format => 'rss'
    site.connect '/feed/atom/', :action => 'articles_feed', :format => 'atom'
    site.connect '/sitemap.xml', :action => 'sitemap'
    site.root :action => 'page_show', :url => '/'
    site.connect '*url', :action => 'page_show'
  end

end