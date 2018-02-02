require "rails_helper"

RSpec.describe RestaurantsController, type: :controller do
  let! :restaurant_one {FactoryBot.create :restaurant}
  let! :restaurant_two {FactoryBot.create :restaurant}

  describe "GET #index" do
    before {get :index} # = before :each {} or before :example {}

    it "should get http status success" do
      expect(response).to have_http_status :success
    end

    it "should render index view template" do
      expect(response).to render_template :index
    end

    it "should retrieve list of restaurant" do
      expect(assigns :restaurants).to eq [restaurant_one, restaurant_two]
    end
  end

  describe "GET #show" do
    context "in case restaurant exist" do
      before {get :show, params: {id: restaurant_one}}

      it "should get http status code success" do
        expect(response).to have_http_status :success
      end

      it "should retrieve right restaurant instance from database" do
        expect(assigns :restaurant).to eq restaurant_one
      end

      it "should render show template view" do
        expect(response).to render_template :show
      end
    end

    context "in case restaurant does not exist" do
      before {get :show, params: {id: 999}}

      it "should return redirect http status code" do
        expect(response).to have_http_status :redirect
      end

      it "then restaurant instance should be nil" do
        expect(assigns :restaurant).to eq nil
      end

      it "should raise right flash message" do
        expect(flash[:danger]).to eq I18n.t "restaurant.controller.show_message"
      end

      it "should redirect to index action" do
        expect(response).to redirect_to action: :index
      end
    end
  end

  describe "GET #new" do
    before {get :new}

    it "should return http status code success" do
      expect(response).to have_http_status :success
    end

    it "should initiate a new restaurant instance" do
      # expect((assigns :restaurant).attributes.values.any?).to be_falsy
      expect(assigns :restaurant).to be_a_new Restaurant
    end

    it "should render new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with invalid form input" do
      it "should create restaurant failed if no name" do
        expect do
          post :create, params: {restaurant: {address: "Testing address"}}
        end.to_not change(Restaurant, :count)
        expect(response).to render_template :new
        expect(flash[:warning]).to eq I18n.t "restaurant.controller.create_failed"
        expect((assigns :restaurant).valid?).to be_falsy
      end

      it "should create restaurant failed if no address" do
        expect do
          post :create, params: {restaurant: {name: "Testing name"}}
        end.to_not change(Restaurant, :count)
        expect(response).to render_template :new
        expect(flash[:warning]).to eq I18n.t "restaurant.controller.create_failed"
        expect((assigns :restaurant).valid?).to be_falsy
      end
    end

    context "with valid form input" do
      it "should create restaurant success" do
        expect do
          post :create, params: {restaurant: {name: "Testing name", address: "Testing address"}}
        end.to change(Restaurant, :count).by 1
        expect((assigns :restaurant).valid?).to be_truthy
        expect(flash[:success]).to eq I18n.t "restaurant.controller.create_success"
        expect(response).to redirect_to action: :index
      end
    end
  end

  describe "GET #edit" do
    context "with available resource" do
      before {get :edit, params: {id: restaurant_one}}

      it "should return success http status code" do
        expect(response).to have_http_status :success
      end

      it "should retrieve right restaurant" do
        expect(assigns :restaurant).to eq restaurant_one
      end

      it "should render edit template view" do
        expect(response).to render_template :edit
      end
    end

    context "with resource do not exist" do
      before {get :edit, params: {id: 999}}

      it "should redirect to index" do
        expect(response).to redirect_to restaurants_path
      end

      it "should generate flash message" do
        expect(flash[:danger]).to eq "Restaurant doesn't exist"
      end

      it "should have redirect status code" do
        expect(response).to have_http_status :redirect
      end
    end
  end

  describe "PATCH #update" do
    context "with valid form input" do
      it "then restaurant must be update successfully" do
        patch_update "Updated name", "Updated address"

        restaurant = assigns :restaurant
        expect(restaurant.name).to eq "Updated name"
        expect(restaurant.address).to eq "Updated address"
        expect(flash[:success]).to eq "Update restaurant successfully"
        expect(response).to redirect_to restaurants_path
      end
    end

    context "with invalid form input" do
      it "update failed if no name" do
        patch_update "", "Updated address"

        expect(flash[:danger]).to eq "Update restaurant failed"
        expect(response).to render_template :edit
      end

      it "update failed if no address" do
        patch_update "Updated name", ""

        expect(flash[:danger]).to eq "Update restaurant failed"
        expect(response).to render_template :edit
      end
    end

    def patch_update name, address
      patch :update, params: {id: restaurant_one,
          restaurant: {name: name, address: address}}
    end
  end

  describe "DELETE #destroy" do
    it "should delete successfully" do
      expect do
        delete :destroy, params: {id: restaurant_one}
      end.to change(Restaurant, :count).by -1
      expect(flash[:success]).to eq "Restaurant deleted successfully"
      expect(response).to redirect_to restaurants_path
    end
  end
end
