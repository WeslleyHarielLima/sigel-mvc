require "application_system_test_case"

class GTipoCombustivelsTest < ApplicationSystemTestCase
  setup do
    @g_tipo_combustivel = g_tipos_combustiveis(:one)
  end

  test "visiting the index" do
    visit g_tipos_combustiveis_url
    assert_selector "h1", text: "G tipo combustivels"
  end

  test "should create g tipo combustivel" do
    visit g_tipos_combustiveis_url
    click_on "New g tipo combustivel"

    fill_in "Descricao", with: @g_tipo_combustivel.descricao
    click_on "Create G tipo combustivel"

    assert_text "G tipo combustivel was successfully created"
    click_on "Back"
  end

  test "should update G tipo combustivel" do
    visit g_tipo_combustivel_url(@g_tipo_combustivel)
    click_on "Edit this g tipo combustivel", match: :first

    fill_in "Descricao", with: @g_tipo_combustivel.descricao
    click_on "Update G tipo combustivel"

    assert_text "G tipo combustivel was successfully updated"
    click_on "Back"
  end

  test "should destroy G tipo combustivel" do
    visit g_tipo_combustivel_url(@g_tipo_combustivel)
    click_on "Destroy this g tipo combustivel", match: :first

    assert_text "G tipo combustivel was successfully destroyed"
  end
end
