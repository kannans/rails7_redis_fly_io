### What is repo?
  This is simple Ruby on Rails application with redis integration.  It has rails 7+, ruby 3.0, redis, postgresql. 
  It's  a example application how to use websocket using redis in rails application.
  
### How it fly.io?
Fly is a platform for running full stack apps and databases. It use to deploy rails application pretty fast. Just few commands the application is production ready.
This process completely on docker image and using fly.toml configure the clusters.

### How it was started?

create account in https://fly.io

```
# create rails application 
rails --version
rails new project_name
cd project_name

# add `pg` and `redis` gems and make necessary changes for websocket changes inside application. 
fly launch
fly deploy
fly open

# create redis instance.
fly redis create
fly secrets set REDIS_URL=redis://default:<redacted>.upstash.io

# deploy again
fly deploy
fly open

```
### How to run this application?
clone this repo `git clone git@github.com:kannans/rails7_redis_fly_io.git`

```
bundle install

bin/rails db:create
bin/rails db:migrate
# or 
bin/rails db:setup

redis-server
bin/rails server

```
Dev url : http://localhost:3000

### Where to acccess production?
https://proud-field-5321.fly.dev/
