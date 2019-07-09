require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

    def setup
        @category= Category.create(name: "sports")
        @user=User.create(username: "zzz", email: "zz@zz.com", password: "zzz", admin: true)

    test "should get category index" do
        get :categories_path
        assert_response :success
    end

    test "should get new" do
        sign_in_as(@user,"zzz")
        get :new_category_path
        assert_response :success
    end

    test "should get show" do
        get category_path(@category)
        assert_response :success
    end

    test "should redirect create when admin not logged in" do
        assert_no_difference 'Category.count' do
        post :create, category: { name: "sports" }
    end    
        assert_redirected_to categories_path 
        end_redirected_to categories_path
    end
end