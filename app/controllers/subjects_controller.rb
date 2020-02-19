class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all
    @all_rooms = all_rooms
    @empty_rooms = all_rooms.map { |e_room| e_room unless Subject.find_by(room: "https://team54.daily.co/#{e_room}") }
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
  end
 
  # GET /subjects/new
  def new
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(title: subject_params[:title], teacher: subject_params[:teacher] )
    @subject.room = create_room(subject_params[:room])

    respond_to do |format|
      if @subject.save
        format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
        format.json { render subjects_path, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to subjects_path, notice: 'Subject was successfully updated.' }
        format.json { render :index, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    daily_room_name = @subject.room[24..-1]
    delete_room(daily_room_name)
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subject_params
      params.require(:subject).permit(:title, :teacher, :room)
    end
end
