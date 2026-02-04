require "application_system_test_case"

class GDistritosTest < ApplicationSystemTestCase
  setup do
    @g_distrito = g_distritos(:one)
  end

  test "visiting the index" do
    visit g_distritos_url
    assert_selector "h1", text: "G distritos"
  end

  test "should create g distrito" do
    visit g_distritos_url
    click_on "New g distrito"

    fill_in "Codigo ibge", with: @g_distrito.codigo_ibge
    fill_in "Descricao", with: @g_distrito.descricao
    fill_in "G municipio", with: @g_distrito.g_municipio_id
    click_on "Create G distrito"

    assert_text "G distrito was successfully created"
    click_on "Back"
  end

  test "should update G distrito" do
    visit g_distrito_url(@g_distrito)
    click_on "Edit this g distrito", match: :first

    fill_in "Codigo ibge", with: @g_distrito.codigo_ibge
    fill_in "Descricao", with: @g_distrito.descricao
    fill_in "G municipio", with: @g_distrito.g_municipio_id
    click_on "Update G distrito"

    assert_text "G distrito was successfully updated"
    click_on "Back"
  end

  test "should destroy G distrito" do
    visit g_distrito_url(@g_distrito)
    click_on "Destroy this g distrito", match: :first

    assert_text "G distrito was successfully destroyed"
  end
end
