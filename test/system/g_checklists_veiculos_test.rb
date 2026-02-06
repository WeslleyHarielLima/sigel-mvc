require "application_system_test_case"

class GChecklistVeiculosTest < ApplicationSystemTestCase
  setup do
    @g_checklist_veiculo = g_checklists_veiculos(:one)
  end

  test "visiting the index" do
    visit g_checklists_veiculos_url
    assert_selector "h1", text: "G checklist veiculos"
  end

  test "should create g checklist veiculo" do
    visit g_checklists_veiculos_url
    click_on "New g checklist veiculo"

    fill_in "G estado conservacao veiculo", with: @g_checklist_veiculo.g_estado_conservacao_veiculo_id
    fill_in "G tipo item checklist veiculo", with: @g_checklist_veiculo.g_tipo_item_checklist_veiculo_id
    fill_in "G vistoria veiculo", with: @g_checklist_veiculo.g_vistoria_veiculo_id
    fill_in "Observacao", with: @g_checklist_veiculo.observacao
    fill_in "Resultado", with: @g_checklist_veiculo.resultado
    click_on "Create G checklist veiculo"

    assert_text "G checklist veiculo was successfully created"
    click_on "Back"
  end

  test "should update G checklist veiculo" do
    visit g_checklist_veiculo_url(@g_checklist_veiculo)
    click_on "Edit this g checklist veiculo", match: :first

    fill_in "G estado conservacao veiculo", with: @g_checklist_veiculo.g_estado_conservacao_veiculo_id
    fill_in "G tipo item checklist veiculo", with: @g_checklist_veiculo.g_tipo_item_checklist_veiculo_id
    fill_in "G vistoria veiculo", with: @g_checklist_veiculo.g_vistoria_veiculo_id
    fill_in "Observacao", with: @g_checklist_veiculo.observacao
    fill_in "Resultado", with: @g_checklist_veiculo.resultado
    click_on "Update G checklist veiculo"

    assert_text "G checklist veiculo was successfully updated"
    click_on "Back"
  end

  test "should destroy G checklist veiculo" do
    visit g_checklist_veiculo_url(@g_checklist_veiculo)
    click_on "Destroy this g checklist veiculo", match: :first

    assert_text "G checklist veiculo was successfully destroyed"
  end
end
