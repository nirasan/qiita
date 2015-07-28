source 'https://rubygems.org'
ruby '2.1.5'
gem 'rails', '4.2.1'
gem 'sass-rails', '~> 5.0'
gem 'compass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'devise'
gem 'devise-bootstrap-views'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'figaro'
gem 'haml-rails'
gem 'simple_form'
gem 'enumerize'
gem "kaminari"
gem 'default_value_for'
gem 'redcarpet'
gem 'diff_match_patch'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'html2haml'
  gem 'erb2haml'
  gem 'letter_opener'
  gem 'heroku_san', git: 'git://github.com/jphenow/heroku_san', branch: 'bug/wrong-ruby-version-loaded'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
end

group :development, :test do
  gem 'sqlite3'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'thin'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'hirb'
  gem 'hirb-unicode'
end

group :production do
  gem 'unicorn'
  gem 'rails_12factor'
  gem 'pg'
end

group :test do
  gem 'capybara'
  gem 'database_rewinder'
  gem 'email_spec'
end
