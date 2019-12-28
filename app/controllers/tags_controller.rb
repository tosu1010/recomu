class TagsController < ApplicationController
  def search
    @tags = Tag.search(params[:tag])
    respond_to do |format|
      format.html
      format.json
    end
  end
end
