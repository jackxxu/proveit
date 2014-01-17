require 'spec_helper'

describe CasesController do

  describe "GET index" do
    it "assigns all cases as @cases", :vcr do
      get :index, {}
      expect(assigns(:cases)).to be_a(Array)
      expect(assigns(:cases).first).to be_a(Hash)
    end
  end

  describe "GET show" do
    it "assigns the requested case as @case", :vcr do
      get :show, {:id => 1}
      expect(assigns(:case)).to be_a(Hash)
    end
  end

end
