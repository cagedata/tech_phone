# TechPhone

To start your Phoenix app:

  1. Install dependencies with `mix deps.get`
  2. Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  3. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Deploying

1. Create a new Heroku using the Elixir buildpack
    * `$ heroku create --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git"`
2. Add the Phoenix buildpack
    * `$ heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git`
3. Update `config/prod.exs` with the correct URL from Heroku
4. Add secret key to Heroku config:
    * `$ heroku config:set SECRET_KEY_BASE="$(mix phoenix.gen.secret)"`
5. Generate a random string and configure that as the signing salt:
    * `$ heroku config:set SIGNING_SALT="{some random 6-10 character string}"`
5. Add all of the proper environment variables to Heroku config:
    * MAILGUN_API_KEY: API key provided by Mailgun
    * MAILGUN_DOMAIN: Domain setup in Mailgun (ie. cagedata.com)
    * TWILIO_ACCOUNT_SID: Account SID provided by Twilio
    * TWILIO_API_KEY: API key generated in the Twilio dashboard
    * TWILIO_API_SECRET: Secret key generated in the Twilio dashboard
6. Git commit and push to Heroku
7. Run the database migrations
    * `$ heroku run mix ecto.migrate`
8. Drink beer! :beer:
