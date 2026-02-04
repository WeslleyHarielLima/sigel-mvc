require "application_system_test_case"

class GMunicipiosTest < ApplicationSystemTestCase
  setup do
    @g_municipio = g_municipios(:one)
  end

  test "visiting the index" do
    visit g_municipios_url
    assert_selector "h1", text: "G municipios"
  end

  test "should create g municipio" do
    visit g_municipios_url
    click_on "New g municipio"

    fill_in "Codigo ibge", with: @g_municipio.codigo_ibge
    fill_in "Descricao", with: @g_municipio.descricao
    fill_in "G estado", with: @g_municipio.g_estado_id
    click_on "Create G municipio"

    assert_text "G municipio was successfully created"
    click_on "Back"
  end

  test "should update G municipio" do
    visit g_municipio_url(@g_municipio)
    click_on "Edit this g municipio", match: :first

    fill_in "Codigo ibge", with: @g_municipio.codigo_ibge
    fill_in "Descricao", with: @g_municipio.descricao
    fill_in "G estado", with: @g_municipio.g_estado_id
    click_on "Update G municipio"

    assert_text "G municipio was successfully updated"
    click_on "Back"
  end

  test "should destroy G municipio" do
    visit g_municipio_url(@g_municipio)
    click_on "Destroy this g municipio", match: :first

    assert_text "G municipio was successfully destroyed"
  end
end
