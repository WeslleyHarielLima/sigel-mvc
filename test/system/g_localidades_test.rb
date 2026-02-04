require "application_system_test_case"

class GLocalidadesTest < ApplicationSystemTestCase
  setup do
    @g_localidade = g_localidades(:one)
  end

  test "visiting the index" do
    visit g_localidades_url
    assert_selector "h1", text: "G localidades"
  end

  test "should create g localidade" do
    visit g_localidades_url
    click_on "New g localidade"

    fill_in "Descricao", with: @g_localidade.descricao
    fill_in "G distrito", with: @g_localidade.g_distrito_id
    click_on "Create G localidade"

    assert_text "G localidade was successfully created"
    click_on "Back"
  end

  test "should update G localidade" do
    visit g_localidade_url(@g_localidade)
    click_on "Edit this g localidade", match: :first

    fill_in "Descricao", with: @g_localidade.descricao
    fill_in "G distrito", with: @g_localidade.g_distrito_id
    click_on "Update G localidade"

    assert_text "G localidade was successfully updated"
    click_on "Back"
  end

  test "should destroy G localidade" do
    visit g_localidade_url(@g_localidade)
    click_on "Destroy this g localidade", match: :first

    assert_text "G localidade was successfully destroyed"
  end
end
