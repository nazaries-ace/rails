require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
    def setup
        @user = User.create(username: "Jack", email: "jack@google.com", password: "1234", admin: true)
    end
    
    test "get new category form and create category" do
        #byebug
        sign_in_as(@user)
        get new_category_path
        assert_template 'categories/new'
        assert_difference 'Category.count', 1 do
            post categories_path, params: { category: { name: "sports" } }
            follow_redirect!
        end
        assert_template 'categories/index'
        assert_match "sports", response.body
    end
    
    test "invalid category submission results in failure" do
        sign_in_as(@user)
        get new_category_path
        assert_template 'categories/new'
        assert_no_difference 'Category.count' do
            post categories_path, params: { category: {name: " "} }
        end 
        assert_template 'categories/new'
        assert_select 'h2.bg-dark.text-white'
        assert_select 'div.row.mb-3'
    end
end