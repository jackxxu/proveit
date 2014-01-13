require 'spec_helper'

describe CasesController do

  let(:filter) { Filter.new(1, 'filter 1') }
  let(:sample_case) { Case.new(1, 'case 1') }

  describe "GET index" do
    it "assigns all cases as @cases" do
      DeskApi.stub_chain(:client, :filters, :entries).and_return([filter])
      filter.stub_chain(:cases, :entries).and_return([sample_case])

      get :index, {}
      expect(assigns(:cases)).to eq([sample_case])
    end
  end

  describe "GET show" do
    it "assigns the requested case as @case" do
      DeskApi.stub_chain(:client, :cases, :find).and_return(sample_case)
      get :show, {:id => sample_case.id}
      expect(assigns(:case)).to eq(sample_case)
    end
  end

end
