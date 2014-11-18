Welcome to Global Consultant Exchange.

This readme will guide you through the steps needed to get your development environment up and
running.

Make sure that you have your dependencies installed.

* Ruby 2.1
* Rails 4.1.1
* PostegreSQL 9.3
* Mailcatcher gem
* Foreman gem
* Elasticsearch
* Redis

Redis

Set your redis ENV variable.  Only neccessary in Production/Staging or if your redis isn't hosted
 with defaults.

```
set REDIS_URL='your_url'
```

Mailcatcher & Foreman

```
gem install mailcatcher
gem install foreman
foreman start
```
Foreman will launch and monitor all the processes needed to run GCES

Go to http://localhost:1080/
Send mail through smtp://localhost:1025

Create a google geolocation key
https://developers.google.com/maps/documentation/business/

Create a bing maps api key
http://www.bingmapsportal.com

Generate a secret key and save your keys as ENV variables.
Generate a password for the company superuser password.
Generate elastic search ENV variables.
```
rake secret
vim ~/.bash_profile

export SECRET_KEY_BASE=${secret_key}
export GOOGLE_MAPS_API=${google_maps_api_key}
export BING_MAPS_API=${bing_maps_api_key}
export COMPANY_SUPERUSER_PASS=${company_superuser_pass}
export ELASTICSEARCH_HOST=${elasticsearch_host}
export ELASTICSEARCH_USER=${elasticsearch_user}
export ELASTICSEARCH_PASSWORD=${elasticsearch_password}

```

Initialize your application by running
```
bin/init ./
```
in your working directory.  This will install your gems as well as load your DB.


Run guard to execute tests, brakeman and start spring.

```
guard
```


Run rails s to start the server on localhost:3000
```
rails s
```

Or alternatively use something like pow http://pow.cx/
