# Ayn Rand Translations site

Developer setup:

1. `git clone` this repo and cd into it
2. Make sure you have the correct Ruby version installed (check `.ruby-version`, as of this writing it is 2.3.3). [RVM](https://rvm.io) is recommended if you need to install.
3. Make sure you have Bundler installed (the `bundle` command). If not, `gem install bundle`
4. Install all the gems by running `bundle`
5. Set up the database with `rake db:setup`

Then you can:

* Run the server with `rails server` and go to http://localhost:3000 to see the app
* Run the tests with `rake test`
