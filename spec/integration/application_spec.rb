require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it "should return the list of albums" do
      response = get("/albums")

      expect(response.status).to eq(200)
      expect(response.body).to include('Title: <a href="/albums/2">Surfer Rosa</a>')
      expect(response.body).to include("Released: 1988")
      expect(response.body).to include('Title: <a href="/albums/3">Waterloo</a>')
    end
  end

  context "GET /albums/:id" do
    it "returns the album with the specific given id" do
      response = get("/albums/2")

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Surfer Rosa</h1>")
      expect(response.body).to include("Release year: 1988")
      expect(response.body).to include("Artist: Pixies")
    end
  end

  context "POST /albums" do
    it "should create a new album" do
      response = post("/albums", title: "Voulez-Vous", release_year: "1979", artist_id: "2")

      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      get = get("/albums")

      expect(get.body).to include("Voulez-Vous")
    end
  end

  context "GET /artists" do
    it "should return the list of artists" do
      response = get("/artists")

      expect(response.status).to eq(200)
      expect(response.body).to eq("Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos")
    end
  end

  context "GET /artists/:id" do
    it "returns the artist with the specific given id" do
      response = get("/artists/2")

      expect(response.status).to eq(200)
      expect(response.body).to include("ABBA")
      expect(response.body).to include("Pop")
    end
  end

  context "POST /artists" do
    it "should create a new artist" do
      response = post("/artists", name: "Miley Cyrus", genre: "Pop")

      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      get = get("/artists")

      expect(get.body).to include("Miley Cyrus")
    end
  end

end