require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:one)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "Products"
  end

  test "should create product" do
    visit products_url
    click_on "New product"

    fill_in "Name", with: @product.name
    fill_in "Quantity", with: @product.quantity
    fill_in "Store", with: @product.store_id
    fill_in "Total cost", with: @product.total_cost
    fill_in "Unit", with: @product.unit
    fill_in "Unit price", with: @product.unit_price
    click_on "Create Product"

    assert_text "Product was successfully created"
    click_on "Back"
  end

  test "should update Product" do
    visit product_url(@product)
    click_on "Edit this product", match: :first

    fill_in "Name", with: @product.name
    fill_in "Quantity", with: @product.quantity
    fill_in "Store", with: @product.store_id
    fill_in "Total cost", with: @product.total_cost
    fill_in "Unit", with: @product.unit
    fill_in "Unit price", with: @product.unit_price
    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "should destroy Product" do
    visit product_url(@product)
    accept_confirm { click_on "Destroy this product", match: :first }

    assert_text "Product was successfully destroyed"
  end
end
