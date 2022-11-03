### What is repo?
  This is simple Ruby on Rails application with redis integration.  It has rails 7+, ruby 3.0, redis, postgresql. 
  It's  a example application how to use websocket using redis in rails application. It's running on Fly.io.
  
### What is fly.io?
It's a cloud platform for application deployment. Alternate for Heroku.com

Fly.io is a platform for running full stack apps and databases. It use to deploy rails application pretty fast. Just few commands the application is production ready. This process completely on docker image and using fly.toml configuration, its runs on fly.io clusters

Note: Its free and no payment cards required. *Best comparing to Heroku.

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

### Why redis?
With Redis, you write fewer lines of code to store, access, and use data in your applications. In rails application it act best for caching and websockets.


### Where to acccess production?
https://proud-field-5321.fly.dev/


### how to use complete bundle of Bootstrap 5 css framework?
Build fast, responsive sites with Bootstrap Powerful, extensible, and feature-packed frontend toolkit. Build and customize with Sass, utilize prebuilt grid system and components, and bring projects to life with powerful JavaScript plugins.

Add bootstrap gem for css style
```rb
gem 'bootstrap', '~> 5.2.2'
```
We need to import this css style to our application stylesheets. 
Before that We should rename `application.css` to `application.scss`

`application.scss` file import the bootstrap bundle
```
....
 *
 *= require_tree .
 *= require_self
 */

@import "bootstrap";  
```
Now we have to import bootstrap javascripts. Import by using `importmap`

```
./bin/importmap pin bootstrap  
```

this will add following two lines in to `importmap.rb`

```
....
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.2.2/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.6/lib/index.js"
```

simply include this line in to `applicaiton.js`, It will include all`(*)` the bootstrap js plugins.

```
...
import * as bootstrap from 'bootstrap'
```
It works!!!
 
