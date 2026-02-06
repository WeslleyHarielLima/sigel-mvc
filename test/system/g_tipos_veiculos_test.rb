require "application_system_test_case"

class GTipoVeiculosTest < ApplicationSystemTestCase
  setup do
    @g_tipo_veiculo = g_tipos_veiculos(:one)
  end

  test "visiting the index" do
    visit g_tipos_veiculos_url
    assert_selector "h1", text: "G tipo veiculos"
  end

  test "should create g tipo veiculo" do
    visit g_tipos_veiculos_url
    click_on "New g tipo veiculo"

    fill_in "Descricao", with: @g_tipo_veiculo.descricao
    click_on "Create G tipo veiculo"

    assert_text "G tipo veiculo was successfully created"
    click_on "Back"
  end

  test "should update G tipo veiculo" do
    visit g_tipo_veiculo_url(@g_tipo_veiculo)
    click_on "Edit this g tipo veiculo", match: :first

    fill_in "Descricao", with: @g_tipo_veiculo.descricao
    click_on "Update G tipo veiculo"

    assert_text "G tipo veiculo was successfully updated"
    click_on "Back"
  end

  test "should destroy G tipo veiculo" do
    visit g_tipo_veiculo_url(@g_tipo_veiculo)
    click_on "Destroy this g tipo veiculo", match: :first

    assert_text "G tipo veiculo was successfully destroyed"
  end
end
