## Server Setup ##

The only external need is Postgres. This can be downloaded here: https://www.postgresql.org/download/

Once you have cloned this app you can run:
```bash
bundle install
bundle exec rake db:create db:migrate
rails s
``` 
