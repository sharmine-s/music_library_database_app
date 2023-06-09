# POST /albums Route Design Recipe
## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

|What does it do?|Method|Path|Body parameters?|
|--|--|--|--|
|Creates an album in the albums table|`POST`|`/albums`|`title`, `release_year`, `artist_id`|

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

When calling `POST /album` for album title `Voulez-Vous` release_year `1979` artist_id `2`
```
response: 200 OK
```

When calling `GET /albums`
```
response: 200 OK

body: Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring, Voulez-Vous
```

## 3. Write Examples

_Replace these with your own design._

```
# Request:

POST /albums
body params title: Voulez-Vous release_year: 1979 artist_id: 2

# Expected response:

Response for 200 OK
```

```
# Request:

GET /albums

# Expected response:

Response for 200 OK

Body:
Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring, Voulez-Vous
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /" do
    it 'returns 200 OK' do
      # Assuming the post with id 1 exists.
      response = get('/posts?id=1')

      expect(response.status).to eq(200)
      # expect(response.body).to eq(expected_response)
    end

    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.