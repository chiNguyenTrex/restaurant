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

  feature "update a restaurant" do
    given! :restaurant {FactoryBot.create :restaurant}

    scenario "with invalid input form" do
      navigate_and_inspect_on_index_page restaurant
      navigate_edit_form_then_check_and_fill restaurant, "Updated name", "Updated address"

      expect(page).to have_text "Update restaurant successfully"
      expect(page).to have_text "Updated name"
      expect(page).to have_text "Updated address"
      expect(page).to_not have_text restaurant.name
      expect(page).to_not have_text restaurant.address
    end

    scenario "with no name supplied" do
      visit restaurants_path
      navigate_edit_form_then_check_and_fill restaurant, "", "Updated address"

      expect(page).to have_text "Update restaurant failed"
    end

    scenario "with no address supplied" do
      visit restaurants_path
      navigate_edit_form_then_check_and_fill restaurant, "Updated name", ""

      expect(page).to have_text "Update restaurant failed"
    end
  end

  feature "delete a restaurant" do
    given! :restaurant_one {FactoryBot.create :restaurant}
    given! :restaurant_two {FactoryBot.create :restaurant}

    scenario "should be successfully" do
      name = restaurant_one.name
      address = restaurant_one.address
      visit restaurants_path

      expect(page).to have_text name
      expect(page).to have_text address

      within ".restaurant-#{restaurant_one.id}" do
        click_link "Delete"
      end

      expect(page).to_not have_text name
      expect(page).to_not have_text address
      expect(page).to have_text "Restaurant deleted successfully"
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

  def navigate_and_inspect_on_index_page restaurant
    visit restaurants_path
    expect(page).to have_content restaurant.name
    expect(page).to have_content restaurant.address
  end

  def navigate_edit_form_then_check_and_fill restaurant, fill_name, fill_address
    within ".restaurant-#{restaurant.id}" do
      click_link "Update"
    end

    expect(page).to have_field "restaurant[name]", with: restaurant.name
    expect(page).to have_field "restaurant[address]", with: restaurant.address

    fill_in "restaurant[name]", with: fill_name
    fill_in "restaurant[address]", with: fill_address
    click_button "Update"
  end
end
