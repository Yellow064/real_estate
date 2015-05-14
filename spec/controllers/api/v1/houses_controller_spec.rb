require 'spec_helper'

describe Api::V1::HousesController do
	describe "GET #show" do
		before(:each) do
			@house = FactoryGirl.create :house
			get :show, id: @house.id
		end

		it "returns the information about a reporter on a hash" do
			house_response = json_response
			expect(house_response[:title]).to eql @house.title
		end

		it { should respond_with 200 }
	end

	describe "GET #index" do
		before(:each) do
			4.times { FactoryGirl.create :house }
			get :index
		end

		it "returns 4 records from the database" do
			house_response = json_response
			expect(house_response[:houses]).to have(4).items
		end

		it { should respond_with 200 }
	end

end
