class CasesController < ApplicationController
  # GET /cases
  def index
    # get the cases under the first filter
    @filter = get_json('filters')['_embedded']['entries'].first
    @cases  = get_json(@filter['_links']['cases']['href'])['_embedded']['entries']
  end

  # GET /cases/1
  def show
    @case = get_json("cases/#{params[:id]}")
  end
end
