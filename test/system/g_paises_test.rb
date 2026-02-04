require "application_system_test_case"

class GPaisTest < ApplicationSystemTestCase
  setup do
    @g_pais = g_paises(:one)
  end

  test "visiting the index" do
    visit g_paises_url
    assert_selector "h1", text: "G pais"
  end

  test "should create g pais" do
    visit g_paises_url
    click_on "New g pais"

    fill_in "Descricao", with: @g_pais.descricao
    fill_in "Sigla", with: @g_pais.sigla
    click_on "Create G pais"

    assert_text "G pais was successfully created"
    click_on "Back"
  end

  test "should update G pais" do
    visit g_pais_url(@g_pais)
    click_on "Edit this g pais", match: :first

    fill_in "Descricao", with: @g_pais.descricao
    fill_in "Sigla", with: @g_pais.sigla
    click_on "Update G pais"

    assert_text "G pais was successfully updated"
    click_on "Back"
  end

  test "should destroy G pais" do
    visit g_pais_url(@g_pais)
    click_on "Destroy this g pais", match: :first

    assert_text "G pais was successfully destroyed"
  end
end
