class SessionsController < ApplicationController
  def show
    @clicked = params[:subject]
    @subjects = Subject.all
    if @clicked
    @start_session_link = Subject.find_by_id(@clicked)[:room]
    end
  end

  def index
  end

end
