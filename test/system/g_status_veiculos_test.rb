require "application_system_test_case"

class GStatusVeiculosTest < ApplicationSystemTestCase
  setup do
    @g_status_veiculo = g_status_veiculos(:one)
  end

  test "visiting the index" do
    visit g_status_veiculos_url
    assert_selector "h1", text: "G status veiculos"
  end

  test "should create g status veiculo" do
    visit g_status_veiculos_url
    click_on "New g status veiculo"

    fill_in "Descricao", with: @g_status_veiculo.descricao
    click_on "Create G status veiculo"

    assert_text "G status veiculo was successfully created"
    click_on "Back"
  end

  test "should update G status veiculo" do
    visit g_status_veiculo_url(@g_status_veiculo)
    click_on "Edit this g status veiculo", match: :first

    fill_in "Descricao", with: @g_status_veiculo.descricao
    click_on "Update G status veiculo"

    assert_text "G status veiculo was successfully updated"
    click_on "Back"
  end

  test "should destroy G status veiculo" do
    visit g_status_veiculo_url(@g_status_veiculo)
    click_on "Destroy this g status veiculo", match: :first

    assert_text "G status veiculo was successfully destroyed"
  end
end
