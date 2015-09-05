[![CircleCI](https://circleci.com/gh/c-brenn/signup.svg?style=shield)](https://circleci.com/gh/c-brenn/signup)  
# DUCSS Signup Backend
Backend for DUCSS' freshers' week signup app, written in rails and designed for heroku(-ish) deployment.

## Dependencies
You will need: 
* A Ruby
* A Bundler
* A Git

### Clone
First things first, clone the repo:  
```bash
git clone git@github.com:c-brenn/signup.git
```  

### Ruby
You can install and manage ruby easily using [rbenv](https://github.com/sstephenson/rbenv). Step by step instructions on how to install rbenv and then ruby are on the github page. At the time of writing this rails app uses ruby 2.2.2 (check the .ruby-version file to see if I'm telling the truth), so I'd recommend installing that.

### Bundler

With ruby installed and aliased you can now install bundler:  
```bash
gem install bundler
```  
With bundler installed you can now install and manage the app's dependencies.
```bash
cd signup
bundle install --path vendor/bundle
```
Now that they're all installed you will need to set up the database:
```bash
bundle exec rake:db migrate
```  
### Add a User

Now that you have everything installed and configured you can run the server. You'll need to create a user or else you won't be able to log in. Open the rails console  
```bash
bundle exec rails c
```
then create a user  
```ruby
User.create(email: 'spoot@bean.com', password: 'magnusman', password_confirmation: 'magnusman')
```  
### Run the Server
You can run the server on `http://localhost:3000` with bundler:  
```bash
bundle exec rails s
```  

## Run the Tests
If you feel so inclined you can run the tests:  
```bash
bundle exec rspec
```  

# Deploy
The easiest way to deploy this app is probably [Heroku](https://heroku.com). That being said, I have used [Dokku](https://github.com/progrium/dokku) on [DigitalOcean](https://www.digitalocean.com) and will now endeavour to tell you how to do just that.

### DNS
Thankfully Dokku provide some nice documentation telling you how to set up DNS correctly for a server running Dokku [here](http://progrium.viewdocs.io/dokku/dns/). It involves pointing two A records at the server, one for yourdomain.com and one for all subdomains of yourdomain.com.  

### Get a Server
DigitalOcean provide a base Dokku image that works out of the box. A guide on how to set it up, with Postgres can be found [here](https://www.digitalocean.com/community/tutorials/how-to-use-the-dokku-one-click-digitalocean-image-to-run-a-ruby-on-rails-app). It involves:
1. Creating a droplet from the Dokku image
2. Installing the [Postgres plugin](https://github.com/Kloadut/dokku-pg-plugin)
3. Deploying your app (git push dokku master)

This app has a little script in `deploy/post-deploy` that runs any pending database migration. You can get this to run after every Dokku deploy easily using [this plugin](https://github.com/mlomnicki/dokku-deploy-hooks)

Once your DNS records propagate you're all done.
