require "application_system_test_case"

class GVistoriaVeiculosTest < ApplicationSystemTestCase
  setup do
    @g_vistoria_veiculo = g_vistorias_veiculos(:one)
  end

  test "visiting the index" do
    visit g_vistorias_veiculos_url
    assert_selector "h1", text: "G vistoria veiculos"
  end

  test "should create g vistoria veiculo" do
    visit g_vistorias_veiculos_url
    click_on "New g vistoria veiculo"

    fill_in "Data vistoria", with: @g_vistoria_veiculo.data_vistoria
    fill_in "G veiculo", with: @g_vistoria_veiculo.g_veiculo_id
    fill_in "Observacoes", with: @g_vistoria_veiculo.observacoes
    fill_in "User", with: @g_vistoria_veiculo.user_id
    click_on "Create G vistoria veiculo"

    assert_text "G vistoria veiculo was successfully created"
    click_on "Back"
  end

  test "should update G vistoria veiculo" do
    visit g_vistoria_veiculo_url(@g_vistoria_veiculo)
    click_on "Edit this g vistoria veiculo", match: :first

    fill_in "Data vistoria", with: @g_vistoria_veiculo.data_vistoria.to_s
    fill_in "G veiculo", with: @g_vistoria_veiculo.g_veiculo_id
    fill_in "Observacoes", with: @g_vistoria_veiculo.observacoes
    fill_in "User", with: @g_vistoria_veiculo.user_id
    click_on "Update G vistoria veiculo"

    assert_text "G vistoria veiculo was successfully updated"
    click_on "Back"
  end

  test "should destroy G vistoria veiculo" do
    visit g_vistoria_veiculo_url(@g_vistoria_veiculo)
    click_on "Destroy this g vistoria veiculo", match: :first

    assert_text "G vistoria veiculo was successfully destroyed"
  end
end
