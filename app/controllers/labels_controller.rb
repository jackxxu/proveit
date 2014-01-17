class LabelsController < ApplicationController

  # GET /labels
  def index
    # gets all the current labels
    @labels = get_json('labels')['_embedded']['entries']
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
      created_label = post_json('labels', @label.attributes)
      # update the first filter's first case to have this new label
      @filter = get_json('filters')['_embedded']['entries'].first
      @case  = get_json(@filter['_links']['cases']['href'])['_embedded']['entries'].first
      put_json(@case['_links']['self']['href'], labels: (@case['labels'] << @label.name))
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
