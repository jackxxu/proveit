require 'spec_helper'

describe LabelsController do

  let(:valid_attributes) {
    {
      name: 'name',
      description: 'description',
      enabled: true,
      color: 'default'
    }
  }
  let(:label) { Label.new(valid_attributes) }
  let(:sample_case) { Case.new(1, 'case 1', []) }

  describe "GET index" do
    it "assigns all labels as @labels" do
      DeskApi.stub_chain(:client, :labels, :entries).and_return([label])
      get :index, {}
      expect(assigns(:labels)).to eq([label])
    end
  end

  describe "GET new" do
    it "assigns a new label as @label" do
      get :new
      expect(assigns(:label)).to be_a(Label)
    end
  end

  describe "POST create" do
    describe "with valid params and no exception occurs" do
      before(:each) do
        Label.any_instance.should_receive(:save).and_return({})
        DeskApi.stub_chain(:client, :filters, :entries, :first, :cases, :entries).and_return([sample_case])
        sample_case.stub(:update).and_return({})
      end

      it "assigns a newly created label as @label" do
        post :create, {:label => valid_attributes}
        expect(assigns(:label)).to be_a(Label)
      end

      it "redirects to the index page" do
        post :create, {:label => valid_attributes}
        expect(response).to redirect_to(labels_path)
      end
    end

    describe "with valid params but exception occurs" do
      before(:each) do
        Label.any_instance.should_receive(:save).and_raise('')
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :create, {:label => valid_attributes}
        expect(response).to render_template("new")
      end
    end

    describe "with invalid params" do
      let(:invalid_attributes) {
        {
          name: 'name',
          color: 'default'
        }
      }

      it "assigns a newly created but not saved" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :create, {:label => invalid_attributes}
        Label.any_instance.should_not_receive(:save)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :create, {:label => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end


end
