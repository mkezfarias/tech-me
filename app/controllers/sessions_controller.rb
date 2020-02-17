class SessionsController < ApplicationController
  def show
    @clicked = params[:bool]
  end

  def index
  end
  
end
