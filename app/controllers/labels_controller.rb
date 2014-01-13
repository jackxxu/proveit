class LabelsController < ApplicationController
  before_action :set_label, only: [:show, :edit, :update, :destroy]

  # GET /labels
  def index
    # gets all the current labels
    @labels = DeskApi.client.labels.entries
  end

  # GET /labels/new
  def new
    @label = Label.new
  end

  # POST /labels
  def create
    # create a new label model and saves it
    @label = Label.new(label_params)
    if @label.valid?
      @label.save
      # update the first filter's first case to have this new label
      first_case = DeskApi.client.filters.entries.first.cases.entries.first
      first_case.update(labels: (first_case.labels << @label.name))
      redirect_to labels_path, notice: 'Label was successfully created.'
    else
      render action: 'new' # invalid label params re-renders the new form
    end
  rescue StandardError => e
    # if any exception occurs, display the error msg and saves on the screen
    flash[:error] = e.message
    render action: 'new'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def label_params
      params[:label]
    end
end
