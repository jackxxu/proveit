require 'spec_helper'

describe LabelsController do

  let(:valid_attributes) {
    {
      "name" => "test 22",
      "description" => "test",
      "enabled" => "1",
      "color" => "default"
    }
  }
  let(:label) { Label.new(valid_attributes) }
  let(:sample_case) { Case.new(1, 'case 1', []) }

  describe "GET index" do
    it "assigns all labels as @labels", :vcr do
      get :index, {}
      expect(assigns(:labels)).to be_a(Array)
      expect(assigns(:labels).first).to be_a(Hash)
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

      it "assigns a newly created label as @label", :vcr do
        post :create, {:label => valid_attributes}
        expect(assigns(:label)).to be_a(Label)
      end

      it "redirects to the index page", :vcr do
        post :create, {:label => valid_attributes}
        expect(response).to redirect_to(labels_path)
      end
    end

    describe "with valid params but exception occurs" do
      let(:invalid_attributes) {
        {
          "name" => "test 22",
          "description" => "test",
          "enabled" => "invalid",
          "color" => "default"
        }
      }
      it "re-renders the 'new' template", :vcr do
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
        LabelsController.any_instance.should_not_receive(:post_json)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :create, {:label => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end


end
