source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 7.1.0'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0', '>= 5.0.8'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2', '>= 4.2.2'

gem 'jquery-rails', '>= 4.3.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '>= 3.5.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.1.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

### Added Gems
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.6'
gem 'ransack', '~> 1.8', '>= 1.8.3'
gem 'devise', '~> 4.7', '>= 4.7.0'

gem 'data-confirm-modal', '~> 1.4', '>= 1.4.0'

group :development, :test do
  gem 'rspec-rails', '~> 3.6', '>= 3.6.0'
  gem 'factory_girl_rails', '~> 4.9', '>= 4.9.0'
  gem 'sqlite3'
end

group :test do
  gem 'capybara', '~> 2.12'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.1'
end

group :production do
  gem 'pg'
end
