# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end
  
  get "/" do
    return erb(:index)
  end

  get "/about" do
    return erb(:about)
  end

  get "/albums" do
    repo = AlbumRepository.new
    @albums = repo.all

    return erb(:albums)
  end

  get "/albums/new" do
    return erb(:new_album)
  end

  get "/albums/:id" do
    repo = AlbumRepository.new
    repo2 = ArtistRepository.new

    album = repo.find(params[:id])
    @title = album.title
    @release_year = album.release_year
    @artist = repo2.find(album.artist_id).name

    return erb(:album)
  end

  post "/albums" do
    repo = AlbumRepository.new
    new_album = Album.new
    artists = ArtistRepository.new

    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]

    repo.create(new_album)
    
    @new_album_title = params[:title]
    
    return erb(:album_created)
  end

  get "/artists" do
    repo = ArtistRepository.new
    @artists = repo.all

    return erb(:artists)
  end

  get "/artists/new" do
    return erb(:new_artist)
  end

  get "/artists/:id" do
    repo = ArtistRepository.new
    @artist = repo.find(params[:id])

    return erb(:artist)
  end

  post '/artists' do
    repo = ArtistRepository.new
    artist = Artist.new

    artist.name = params[:name]
    artist.genre = params[:genre]
    repo.create(artist)

    @new_artist = params[:name]

    return erb(:artist_created)
  end

end