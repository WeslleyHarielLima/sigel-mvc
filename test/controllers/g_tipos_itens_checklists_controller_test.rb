require "test_helper"

class GTiposItensChecklistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_tipo_item_checklist = g_tipos_itens_checklists(:one)
  end

  test "should get index" do
    get g_tipos_itens_checklists_url
    assert_response :success
  end

  test "should get new" do
    get new_g_tipo_item_checklist_url
    assert_response :success
  end

  test "should create g_tipo_item_checklist" do
    assert_difference("GTipoItemChecklist.count") do
      post g_tipos_itens_checklists_url, params: { g_tipo_item_checklist: { criterio_objetivo: @g_tipo_item_checklist.criterio_objetivo, descricao: @g_tipo_item_checklist.descricao, peso: @g_tipo_item_checklist.peso } }
    end

    assert_redirected_to g_tipo_item_checklist_url(GTipoItemChecklist.last)
  end

  test "should show g_tipo_item_checklist" do
    get g_tipo_item_checklist_url(@g_tipo_item_checklist)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_tipo_item_checklist_url(@g_tipo_item_checklist)
    assert_response :success
  end

  test "should update g_tipo_item_checklist" do
    patch g_tipo_item_checklist_url(@g_tipo_item_checklist), params: { g_tipo_item_checklist: { criterio_objetivo: @g_tipo_item_checklist.criterio_objetivo, descricao: @g_tipo_item_checklist.descricao, peso: @g_tipo_item_checklist.peso } }
    assert_redirected_to g_tipo_item_checklist_url(@g_tipo_item_checklist)
  end

  test "should destroy g_tipo_item_checklist" do
    assert_difference("GTipoItemChecklist.count", -1) do
      delete g_tipo_item_checklist_url(@g_tipo_item_checklist)
    end

    assert_redirected_to g_tipos_itens_checklists_url
  end
end
