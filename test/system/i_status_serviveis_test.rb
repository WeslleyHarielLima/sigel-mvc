require "application_system_test_case"

class IStatusServivelsTest < ApplicationSystemTestCase
  setup do
    @i_status_servivel = i_status_serviveis(:one)
  end

  test "visiting the index" do
    visit i_status_serviveis_url
    assert_selector "h1", text: "I status servivels"
  end

  test "should create i status servivel" do
    visit i_status_serviveis_url
    click_on "New i status servivel"

    fill_in "Descricao", with: @i_status_servivel.descricao
    click_on "Create I status servivel"

    assert_text "I status servivel was successfully created"
    click_on "Back"
  end

  test "should update I status servivel" do
    visit i_status_servivel_url(@i_status_servivel)
    click_on "Edit this i status servivel", match: :first

    fill_in "Descricao", with: @i_status_servivel.descricao
    click_on "Update I status servivel"

    assert_text "I status servivel was successfully updated"
    click_on "Back"
  end

  test "should destroy I status servivel" do
    visit i_status_servivel_url(@i_status_servivel)
    click_on "Destroy this i status servivel", match: :first

    assert_text "I status servivel was successfully destroyed"
  end
end
