require "application_system_test_case"

class GMarcaVeiculosTest < ApplicationSystemTestCase
  setup do
    @g_marca_veiculo = g_marcas_veiculos(:one)
  end

  test "visiting the index" do
    visit g_marcas_veiculos_url
    assert_selector "h1", text: "G marca veiculos"
  end

  test "should create g marca veiculo" do
    visit g_marcas_veiculos_url
    click_on "New g marca veiculo"

    fill_in "Descricao", with: @g_marca_veiculo.descricao
    click_on "Create G marca veiculo"

    assert_text "G marca veiculo was successfully created"
    click_on "Back"
  end

  test "should update G marca veiculo" do
    visit g_marca_veiculo_url(@g_marca_veiculo)
    click_on "Edit this g marca veiculo", match: :first

    fill_in "Descricao", with: @g_marca_veiculo.descricao
    click_on "Update G marca veiculo"

    assert_text "G marca veiculo was successfully updated"
    click_on "Back"
  end

  test "should destroy G marca veiculo" do
    visit g_marca_veiculo_url(@g_marca_veiculo)
    click_on "Destroy this g marca veiculo", match: :first

    assert_text "G marca veiculo was successfully destroyed"
  end
end
