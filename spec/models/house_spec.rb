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

  #validates link between the models
  it { should belong_to :user }


  describe ".filter_by_title" do
    before(:each) do
      @house1 = FactoryGirl.create :house, title: "Cumbres"
      @house2 = FactoryGirl.create :house, title: "Cumbres Elite"
      @house3 = FactoryGirl.create :house, title: "Cumbres blah balh"
      @house4 = FactoryGirl.create :house, title: "Garza Sada"

    end

    context "when a 'Cumbres' title pattern is sent" do
      it "returns the 3 houses matching" do
        expect(House.filter_by_title("Cumbres")).to have(3).items
      end

      it "returns the houses matching" do
        expect(House.filter_by_title("Cumbres").sort).to match_array([@house1,@house2 ,@house3])
      end
    end
  end


  describe ".above_or_equal_to_price" do
    before(:each) do
      @house1 = FactoryGirl.create :house, price: 100
      @house2 = FactoryGirl.create :house, price: 50
      @house3 = FactoryGirl.create :house, price: 150
      @house4 = FactoryGirl.create :house, price: 99
    end

    it "returns the houses which are above or equal to the price" do
      expect(House.above_or_equal_to_price(100).sort).to match_array([@house1, @house3])
    end
  end

  describe ".below_or_equal_to_price" do
    before(:each) do
      @house1 = FactoryGirl.create :house, price: 100
      @house2 = FactoryGirl.create :house, price: 50
      @house3 = FactoryGirl.create :house, price: 150
      @house4 = FactoryGirl.create :house, price: 99
    end

    it "returns the houses which are above or equal to the price" do
      expect(House.below_or_equal_to_price(99).sort).to match_array([@house2, @house4])
    end
  end

  describe ".recent" do
    before(:each) do
      @house1 = FactoryGirl.create :house, price: 100
      @house2 = FactoryGirl.create :house, price: 50
      @house3 = FactoryGirl.create :house, price: 150
      @house4 = FactoryGirl.create :house, price: 99

      @house2.touch
      @house3.touch
    end

    it "returns the most updated records" do
      expect(House.recent).to match_array([@house3, @house2, @house4, @house1])
    end
  end

end
