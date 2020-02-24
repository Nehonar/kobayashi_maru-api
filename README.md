# KobayashiMaru
The Kobayashi Maru is a training exercise in the fictional Star Trek universe designed to test the character of Starfleet Academy cadets in a no-win scenario.

## Docs
You can walk through the application with Docs, you have all the links to the functions,the input and output parameters and a global view of the modules and what they are for.

Run doc/index.html

## What is it doing and what is missing
  - At the moment it lifts the service with which we can create API gateway connections
  and create users in database.
  - I know that this is a part that was not required, but for the future it would be necessary, since if you create a shopping cart, and the customer really wants to make the purchase, in the end all that data should be saved in the database In addition, all products that must be purchased must be subtracted from the stock.
    - On the other hand we must take into account whether the purchase will be taken to a store or directly to the customer's home.
      - If it is to the store, you must specify the store and send the notice to the store.
      - If it is at the client's house, we will need the client's data again.
  - In terms of programming I have been surpassed for being the first time I had to create an API gateway service, I have not had time to do more tests and see how it worked.

## Observations
This project has really demanded my concentration, I had been in a comfort zone for a while in which I only had to review other code and add some functions. I have enjoyed the test and of course I will continue with it whatever your decision with me, sometimes one thinks of practicing some programming but no new ideas arise due to lack of knowledge.

## To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Curl
Let's do a login request. This needs to be a POST request to the /api/sessions route. And we need to pass the email and password as parameters. We already have one user in our app inserted in our seeds.exs.
```
curl --request POST \
  --url http://localhost:4000/api/sessions \
  --header 'authorization: Kobayashi_maru' \
  --header 'content-type: application/x-www-form-urlencoded' \
  --data email=user%40kobayashiMaru \
  --data password=user%40kobayashiMaru
```
Let's try now the logout request. This is a DELETE request that only needs to include the token as a header.
```
curl --request DELETE \
  --url http://localhost:4000/api/sessions \
  --header 'authorization: Kobayashi_maru dpTuOMOGUvS4pIOnW22RjkQxt6TJo780palYEJFFm88ncVTPqOjYTaSENNpedOl' --verbose
```


Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Reference
Guide of API Gateway https://dev.to/miguelcoba/elixir-api-and-elm-spa-4hpf

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
