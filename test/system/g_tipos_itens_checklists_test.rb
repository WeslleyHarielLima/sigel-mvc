require "application_system_test_case"

class GTipoItemChecklistsTest < ApplicationSystemTestCase
  setup do
    @g_tipo_item_checklist = g_tipos_itens_checklists(:one)
  end

  test "visiting the index" do
    visit g_tipos_itens_checklists_url
    assert_selector "h1", text: "G tipo item checklists"
  end

  test "should create g tipo item checklist" do
    visit g_tipos_itens_checklists_url
    click_on "New g tipo item checklist"

    fill_in "Criterio objetivo", with: @g_tipo_item_checklist.criterio_objetivo
    fill_in "Descricao", with: @g_tipo_item_checklist.descricao
    fill_in "Peso", with: @g_tipo_item_checklist.peso
    click_on "Create G tipo item checklist"

    assert_text "G tipo item checklist was successfully created"
    click_on "Back"
  end

  test "should update G tipo item checklist" do
    visit g_tipo_item_checklist_url(@g_tipo_item_checklist)
    click_on "Edit this g tipo item checklist", match: :first

    fill_in "Criterio objetivo", with: @g_tipo_item_checklist.criterio_objetivo
    fill_in "Descricao", with: @g_tipo_item_checklist.descricao
    fill_in "Peso", with: @g_tipo_item_checklist.peso
    click_on "Update G tipo item checklist"

    assert_text "G tipo item checklist was successfully updated"
    click_on "Back"
  end

  test "should destroy G tipo item checklist" do
    visit g_tipo_item_checklist_url(@g_tipo_item_checklist)
    click_on "Destroy this g tipo item checklist", match: :first

    assert_text "G tipo item checklist was successfully destroyed"
  end
end
