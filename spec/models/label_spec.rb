require 'spec_helper'

describe Label do

  describe "#save" do
    let(:label) {Label.new}
    it 'returns the value from DeskApi create method' do
      DeskApi.stub_chain(:client, :labels, :create).and_return({})
      expect(label.save).to eq({})
    end
  end

end
