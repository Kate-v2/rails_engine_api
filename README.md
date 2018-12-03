# README

Requirements:
* ruby '2.4.1'
* rails '5.2.1'

Installation: 
* bundle install
* bundle update
* rake db:{drop,create,migrate,test:prepare}

Additional Gems (in Gemfile):
* gem 'fast_jsonapi'
* gem 'simplecov'
* gem 'shoulda-matchers', '~> 3.1'
* gem 'factory_bot_rails'
* gem 'faker'
* gem 'awesome_print'

Testing
Using RSpec
* rails g rspec:install
* rspec (to run all tests from the terminal)

Seeding:


Data is stored in CSV files (db/data/'*'.csv). Enter order-dependent:
* rake import:merchants
* rake import:customers
* rake import:items
* rake import:invoices
* rake import:transactions
* rake import:invoice_items


(rake tasks stored in /lib/tasks/import_csv.rake)


Rails Engine
-
Models:
* merchant
* customer
* item
* invoice
* transactions
* invoice_items

This JSON only application reveals business insight about the above categories, their relationships, and some statistics, including optional filters.
