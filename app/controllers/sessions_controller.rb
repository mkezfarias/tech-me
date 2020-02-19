class SessionsController < ApplicationController
  def show
    @clicked = params[:subject]
    @subjects = Subject.all
    @start_session_link = Subject.find(@clicked)[:room]
  end

  def index
  end

end
