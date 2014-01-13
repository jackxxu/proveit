class CasesController < ApplicationController
  # GET /cases
  def index
    # get the cases under the first filter
    @filter = DeskApi.client.filters.entries.first
    @cases  = @filter.cases.entries
  end

  # GET /cases/1
  def show
    @case = DeskApi.client.cases.find(params[:id])
  end
end
