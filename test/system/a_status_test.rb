require "application_system_test_case"

class AStatusesTest < ApplicationSystemTestCase
  setup do
    @a_status = a_status(:one)
  end

  test "visiting the index" do
    visit a_status_url
    assert_selector "h1", text: "A statuses"
  end

  test "should create a status" do
    visit a_status_url
    click_on "New a status"

    fill_in "Descricao", with: @a_status.descricao
    click_on "Create A status"

    assert_text "A status was successfully created"
    click_on "Back"
  end

  test "should update A status" do
    visit a_status_url(@a_status)
    click_on "Edit this a status", match: :first

    fill_in "Descricao", with: @a_status.descricao
    click_on "Update A status"

    assert_text "A status was successfully updated"
    click_on "Back"
  end

  test "should destroy A status" do
    visit a_status_url(@a_status)
    click_on "Destroy this a status", match: :first

    assert_text "A status was successfully destroyed"
  end
end
