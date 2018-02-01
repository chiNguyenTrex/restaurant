require "rails_helper"

RSpec.describe Restaurant, type: :model do
  context "columns" do
    it{should have_db_column(:name).of_type(:string)}
    it{should have_db_column(:address).of_type(:string)}
  end

  context "validates" do
    it{should validate_presence_of(:name)}
    it{should validate_presence_of(:address)}
  end

  describe "validates instance" do
    let(:restaurant_no_name){FactoryBot.build :restaurant, name: ""}
    let(:restaurant_no_address){FactoryBot.build :restaurant, address: ""}
    let(:valid_restaurant){FactoryBot.build :restaurant}

    context "have no name" do
      it "should raise right messages error" do
        expect(restaurant_no_name.valid?).to be_falsy
        expect(restaurant_no_name.errors.messages.size).to eq 1
        expect(restaurant_no_name.errors.messages.values.flatten[0]).to match /must be fill in/
      end
    end

    context "have no address" do
      it "should raise right messages error" do
        expect(restaurant_no_address.valid?).to be_falsy
        expect(restaurant_no_address.errors.messages.size).to eq 1
        expect(restaurant_no_address.errors.messages.values.flatten[0]).to match /must be fill in/
      end
    end

    context "have name and address" do
      it "should return valid restaurant" do
        expect(valid_restaurant.valid?).to be_truthy
      end
    end
  end
end
