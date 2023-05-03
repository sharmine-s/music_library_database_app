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
      expect(response.body).to include("Title: Surfer Rosa")
      expect(response.body).to include("Released: 1988")
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

  context "POST /artists" do
    it "should create a new artist" do
      response = post("/artists", name: "Miley Cyrus", genre: "Pop")

      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      get = get("/artists")

      expect(get.body).to include("Miley Cyrus")
    end
  end

  # context "GET /" do
  #   it "returns a hello page if the password is correct" do
  #     response = get("/", password: "abcd")

  #     expect(response.body).to include("Hello!")
  #   end

  #   it "returns a forbidden if the password is incorrect" do
  #     response = get("/", password: "aergtersg")

  #     expect(response.body).to include("Access forbidden")
  #   end
  # end

  context "GET /albums/:id" do
    it "returns the album with the specific given id" do
      response = get("/albums/2")

      expect(response.status).to eq(200)
      expect(response.body).to include("<h1>Surfer Rosa</h1>")
      expect(response.body).to include("Release year: 1988")
      expect(response.body).to include("Artist: Pixies")
    end
  end

end