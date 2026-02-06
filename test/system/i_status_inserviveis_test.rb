require "application_system_test_case"

class IStatusInservivelsTest < ApplicationSystemTestCase
  setup do
    @i_status_inservivel = i_status_inserviveis(:one)
  end

  test "visiting the index" do
    visit i_status_inserviveis_url
    assert_selector "h1", text: "I status inservivels"
  end

  test "should create i status inservivel" do
    visit i_status_inserviveis_url
    click_on "New i status inservivel"

    fill_in "Descricao", with: @i_status_inservivel.descricao
    click_on "Create I status inservivel"

    assert_text "I status inservivel was successfully created"
    click_on "Back"
  end

  test "should update I status inservivel" do
    visit i_status_inservivel_url(@i_status_inservivel)
    click_on "Edit this i status inservivel", match: :first

    fill_in "Descricao", with: @i_status_inservivel.descricao
    click_on "Update I status inservivel"

    assert_text "I status inservivel was successfully updated"
    click_on "Back"
  end

  test "should destroy I status inservivel" do
    visit i_status_inservivel_url(@i_status_inservivel)
    click_on "Destroy this i status inservivel", match: :first

    assert_text "I status inservivel was successfully destroyed"
  end
end
