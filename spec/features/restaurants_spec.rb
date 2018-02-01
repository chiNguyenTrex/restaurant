require "rails_helper"

RSpec.feature "Restaurant management", type: :feature, js: true do
  feature "create a new restaurant" do
    scenario "should be success with valid form input" do
      visit_and_fill_create_restaurant_form "My restaurant", "My address"
      expect(page).to have_text "Create restaurant successfully"
      expect(page).to have_content "My restaurant"
      expect(page).to have_text "My address"
    end

    scenario "should be failed with no name supplied" do
      visit_and_fill_create_restaurant_form "", "My address"
      expect(page).to have_text "Create restaurant failed"
      expect(page).to have_text "Name must be fill in"
    end

    scenario "should be failed with no address supplied" do
      visit_and_fill_create_restaurant_form "My restaurant", ""
      expect(page).to have_text "Create restaurant failed"
      expect(page).to have_text "Address must be fill in"
    end

    scenario "should be failed with no name and address supplied" do
      visit_and_fill_create_restaurant_form "", ""
      expect(page).to have_text "Create restaurant failed"
      expect(page).to have_text "Name must be fill in"
      expect(page).to have_text "Address must be fill in"
    end

  end

  private

  def visit_and_fill_create_restaurant_form name, address
    visit restaurants_path
    click_link "New restaurant"
    fill_in "restaurant[name]", with: name
    fill_in "restaurant[address]", with: address
    click_button "Create"
  end
end
