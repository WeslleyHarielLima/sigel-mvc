require "application_system_test_case"

class AOrgaosTest < ApplicationSystemTestCase
  setup do
    @a_orgao = a_orgaos(:one)
  end

  test "visiting the index" do
    visit a_orgaos_url
    assert_selector "h1", text: "A orgaos"
  end

  test "should create a orgao" do
    visit a_orgaos_url
    click_on "New a orgao"

    fill_in "Descricao", with: @a_orgao.descricao
    click_on "Create A orgao"

    assert_text "A orgao was successfully created"
    click_on "Back"
  end

  test "should update A orgao" do
    visit a_orgao_url(@a_orgao)
    click_on "Edit this a orgao", match: :first

    fill_in "Descricao", with: @a_orgao.descricao
    click_on "Update A orgao"

    assert_text "A orgao was successfully updated"
    click_on "Back"
  end

  test "should destroy A orgao" do
    visit a_orgao_url(@a_orgao)
    click_on "Destroy this a orgao", match: :first

    assert_text "A orgao was successfully destroyed"
  end
end
