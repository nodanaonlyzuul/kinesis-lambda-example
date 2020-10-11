# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'ougai', '~> 1.8', '>= 1.8.2'
gem 'nokogiri', '~> 1.6', '>= 1.6.8'
gem 'sqlite3', '~> 1.3', '>= 1.3.11'
gem 'pg'

# Not needed in deployed environments (AWS)
group :local do
  gem 'pry'
end
