class LinksController < ApplicationController
  def create
    @link = Link.new(params[:link])
    @link.session_id = session[:session_id]
    if @link.save
      respond_to do |format|
        format.html { redirect_to @link }
        format.js
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js
      end
    end
  end

  def short
    @link = Link.find(params[:id])
    redirect_to root_path unless @link
    @link.views += 1
    @link.save
    redirect_to @link.url
  end

  def show
    @link = Link.find(params[:id])
  end

  def new
    @link = Link.new
  end
end
