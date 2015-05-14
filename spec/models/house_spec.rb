require 'spec_helper'

describe House do
  let(:house) { FactoryGirl.build :house }
  subject { house }

  it { should respond_to(:title) }
  it { should respond_to(:price) }
  it { should respond_to(:published) }
  it { should respond_to(:date_published) }
  it { should respond_to(:user_id) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :price }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of :user_id }
end
