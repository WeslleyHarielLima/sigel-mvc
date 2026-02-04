require "application_system_test_case"

class GStatusLeilaoVeiculosTest < ApplicationSystemTestCase
  setup do
    @g_status_leilao_veiculo = g_status_leiloes_veiculos(:one)
  end

  test "visiting the index" do
    visit g_status_leiloes_veiculos_url
    assert_selector "h1", text: "G status leilao veiculos"
  end

  test "should create g status leilao veiculo" do
    visit g_status_leiloes_veiculos_url
    click_on "New g status leilao veiculo"

    fill_in "Descricao", with: @g_status_leilao_veiculo.descricao
    click_on "Create G status leilao veiculo"

    assert_text "G status leilao veiculo was successfully created"
    click_on "Back"
  end

  test "should update G status leilao veiculo" do
    visit g_status_leilao_veiculo_url(@g_status_leilao_veiculo)
    click_on "Edit this g status leilao veiculo", match: :first

    fill_in "Descricao", with: @g_status_leilao_veiculo.descricao
    click_on "Update G status leilao veiculo"

    assert_text "G status leilao veiculo was successfully updated"
    click_on "Back"
  end

  test "should destroy G status leilao veiculo" do
    visit g_status_leilao_veiculo_url(@g_status_leilao_veiculo)
    click_on "Destroy this g status leilao veiculo", match: :first

    assert_text "G status leilao veiculo was successfully destroyed"
  end
end
