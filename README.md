Welcome to Global Consultant Exchange.

This readme will guide you through the steps needed to get your development environment up and
running.

Make sure that you have your dependencies installed.

* Ruby 2.1
* PostegreSQL 9.3
* Mailcatcher gem
* Foreman gem

Mailcatcher & Foreman

```
gem install mailcatcher
gem install foreman
foreman
```
Foreman will launch and monitor all the processes needed to run GCES

Go to http://localhost:1080/
Send mail through smtp://localhost:1025

Initialize your application by running
```
bin/init ./
```
in your working directory.  This will install your gems as well as load your DB.


Run guard to execute tests, brakeman and start spring.

```
bin/guard
```

