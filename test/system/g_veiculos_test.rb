require "application_system_test_case"

class GVeiculosTest < ApplicationSystemTestCase
  setup do
    @g_veiculo = g_veiculos(:one)
  end

  test "visiting the index" do
    visit g_veiculos_url
    assert_selector "h1", text: "G veiculos"
  end

  test "should create g veiculo" do
    visit g_veiculos_url
    click_on "New g veiculo"

    fill_in "Ano", with: @g_veiculo.ano
    fill_in "Chassi", with: @g_veiculo.chassi
    fill_in "Cor", with: @g_veiculo.cor
    fill_in "G status veiculo", with: @g_veiculo.g_status_veiculo_id
    fill_in "Marca", with: @g_veiculo.marca
    fill_in "Modelo", with: @g_veiculo.modelo
    fill_in "Motor", with: @g_veiculo.motor
    fill_in "Numero interno", with: @g_veiculo.numero_interno
    fill_in "Placa", with: @g_veiculo.placa
    fill_in "Renavam", with: @g_veiculo.renavam
    fill_in "Tombamento", with: @g_veiculo.tombamento
    click_on "Create G veiculo"

    assert_text "G veiculo was successfully created"
    click_on "Back"
  end

  test "should update G veiculo" do
    visit g_veiculo_url(@g_veiculo)
    click_on "Edit this g veiculo", match: :first

    fill_in "Ano", with: @g_veiculo.ano
    fill_in "Chassi", with: @g_veiculo.chassi
    fill_in "Cor", with: @g_veiculo.cor
    fill_in "G status veiculo", with: @g_veiculo.g_status_veiculo_id
    fill_in "Marca", with: @g_veiculo.marca
    fill_in "Modelo", with: @g_veiculo.modelo
    fill_in "Motor", with: @g_veiculo.motor
    fill_in "Numero interno", with: @g_veiculo.numero_interno
    fill_in "Placa", with: @g_veiculo.placa
    fill_in "Renavam", with: @g_veiculo.renavam
    fill_in "Tombamento", with: @g_veiculo.tombamento
    click_on "Update G veiculo"

    assert_text "G veiculo was successfully updated"
    click_on "Back"
  end

  test "should destroy G veiculo" do
    visit g_veiculo_url(@g_veiculo)
    click_on "Destroy this g veiculo", match: :first

    assert_text "G veiculo was successfully destroyed"
  end
end
