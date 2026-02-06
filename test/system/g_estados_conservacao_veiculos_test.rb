require "application_system_test_case"

class GEstadoConservacaoVeiculosTest < ApplicationSystemTestCase
  setup do
    @g_estado_conservacao_veiculo = g_estados_conservacao_veiculos(:one)
  end

  test "visiting the index" do
    visit g_estados_conservacao_veiculos_url
    assert_selector "h1", text: "G estado conservacao veiculos"
  end

  test "should create g estado conservacao veiculo" do
    visit g_estados_conservacao_veiculos_url
    click_on "New g estado conservacao veiculo"

    fill_in "Descricao", with: @g_estado_conservacao_veiculo.descricao
    click_on "Create G estado conservacao veiculo"

    assert_text "G estado conservacao veiculo was successfully created"
    click_on "Back"
  end

  test "should update G estado conservacao veiculo" do
    visit g_estado_conservacao_veiculo_url(@g_estado_conservacao_veiculo)
    click_on "Edit this g estado conservacao veiculo", match: :first

    fill_in "Descricao", with: @g_estado_conservacao_veiculo.descricao
    click_on "Update G estado conservacao veiculo"

    assert_text "G estado conservacao veiculo was successfully updated"
    click_on "Back"
  end

  test "should destroy G estado conservacao veiculo" do
    visit g_estado_conservacao_veiculo_url(@g_estado_conservacao_veiculo)
    click_on "Destroy this g estado conservacao veiculo", match: :first

    assert_text "G estado conservacao veiculo was successfully destroyed"
  end
end
