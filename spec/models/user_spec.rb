require 'spec_helper'

describe User do
	before { @user = FactoryGirl.build(:user) }

	subject { @user }

	it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of(:email) }
	it { should validate_confirmation_of(:password) }
	it { should allow_value('example@domain.com').for(:email) }
	# we test the user actually respond to this attribute
	it { should respond_to(:auth_token) }
	# we test the auth_token is unique
	it { should validate_uniqueness_of(:auth_token)}

	describe "#generate_authentication_token!" do
		it "generates a unique token" do
			Devise.stub(:friendly_token).and_return("auniquetoken123")
			@user.generate_authentication_token!
			expect(@user.auth_token).to eql "auniquetoken123"
		end

		it "generates another token when one already has been taken" do
			existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
			@user.generate_authentication_token!
			expect(@user.auth_token).not_to eql existing_user.auth_token
		end
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end
end
