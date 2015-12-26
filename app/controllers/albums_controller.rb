class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :can_access, only: [:edit, :update, :destroy]

  respond_to :html

  def can_access
    if @album.user_id == current_user.id
      return true
    else
      redirect_to root_path, :alert => "Access Denied!!!"
    end
  end

  def index
    @albums = Album.all
    respond_with(@albums)
  end

  def show
    @photos = @album.photos
    respond_with(@album)
  end

  def new
    @album = Album.new
    respond_with(@album)
  end

  def edit
  end

  def create
    @album = Album.new(album_params)
    @album.user = current_user
    @album.save
    respond_with(@album)
  end

  def update
    @album.update(album_params)
    logger.info @album.errors.inspect
    respond_with(@album)
  end

  def destroy
    @album.destroy
    respond_with(@album)
  end

  private
    def set_album
      @album = Album.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:title, :description, :user_id, :photos_attributes => [:id, :title, :album_id, :user_id, :image, :_destroy])
    end
end
