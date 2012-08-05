# Partitioned Routes

For Rails 3.

This enables define routes in Controller( like `config/routes.rb`).


### Example

edit `config/routes.rb`
    Rtest::Application.routes.draw do
      # other routes definition
    
      PartitionedRoutes.define self # <== add this line.
    end

in controller

    class SomethingController < ApplicationController
      # ...
      routes do |r| # this block similer to `config/routes.rb`
        r.resources :something # same as `resources :something` in `config/routes.rb`
      end

      routes :resources # same as `resources :something`

      routes :auto # same as `match this_controller/:action`
      # ...
    end

## Usage

Add this to Gemfile and run `bundle`.
That's it.

    gem 'partitioned_routes', :git => 'git://github.com/tazyamah/partitioned_routes.git'


## Restriction

The generated routes can show in `rake routes`!

I have no idea how to fix it. Please tell me!

## Copyright

Copyright (c) 2012 Tatsuya SUZUKI.

This project rocks and uses MIT-LICENSE.