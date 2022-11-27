### What is repo?
  This is simple Ruby on Rails application with redis integration.  It has rails 7+, ruby 3.0, redis, postgresql. 
  It's  a example application how to use websocket using redis in rails application. It's running on Fly.io.
  
### What is fly.io?
It's a cloud platform for application deployment. Alternate for Heroku.com

Fly.io is a platform for running full stack apps and databases. It use to deploy rails application pretty fast. Just few commands the application is production ready. This process completely on docker image and using fly.toml configuration, its runs on fly.io clusters

Note: Its free and no payment cards required. *Best comparing to Heroku.

### How it was started?

create account in https://fly.io

```sh
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
fly redis connect

# deploy again
fly deploy
fly open

#debug: 

fly ssh console
flyctl secrets unset RAILS_MASTER_KEY
flyctl secrets set RAILS_MASTER_KEY=<value>
fly redis connect
fly logs


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
https://kannansv.fly.dev/


### How to use complete bundle of Bootstrap 5 css framework?
Build fast, responsive sites with Bootstrap Powerful, extensible, and feature-packed frontend toolkit. Build and customize with Sass, utilize prebuilt grid system and components, and bring projects to life with powerful JavaScript plugins.

Add bootstrap gem for css style
```rb
gem 'bootstrap', '~> 5.2.2'
gem 'sassc-rails'
```
We need to import this css style to our application stylesheets. 
Before that We should rename `application.css` to `application.scss`

`application.scss` file import the bootstrap bundle
```css
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

```js
...
import * as bootstrap from 'bootstrap'
```
It works!!!

#### Exceptions and fixes
1) requires node js:  Rails app `fly deploy` failing with ExecJS::RuntimeUnavailable: Could not find a JavaScript runtime find solution here. https://community.fly.io/t/rails-app-fly-deploy-failing-with-execjs-could-not-find-a-javascript-runtime/7904

Actually!!!.. I tweek the code to fix runtime js issue. First include `nodejs` in `DEPLOY_PACKAGES`  list
and update the `fly.task` file with following code.
```rb
task :build #=> 'assets:precompile'
task :server => %i[swapfile assets:precompile]
```

### How to Do Custom Domains With Fly?

```
flyctl ips list -a <appname> #to get the IPv4 and IPv6 addresses.
flyctl certs create -a <appname> example.com
```

You can direct traffic to example.com by:

1: Adding an A record to your DNS service which reads

    A @ xxx.xxx.xxx.104

You can validate your ownership of kannans.dev by:

2: Adding an AAAA record to your DNS service which reads:

    `AAAA @ 2a09:xx:xx::xxxx`
