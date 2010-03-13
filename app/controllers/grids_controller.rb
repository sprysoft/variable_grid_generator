class GridsController < ApplicationController
  
  def index
    respond_to do |format|
      format.css
    end
  end
  
end
