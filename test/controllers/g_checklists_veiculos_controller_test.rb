require "test_helper"

class GChecklistsVeiculosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_checklist_veiculo = g_checklists_veiculos(:one)
  end

  test "should get index" do
    get g_checklists_veiculos_url
    assert_response :success
  end

  test "should get new" do
    get new_g_checklist_veiculo_url
    assert_response :success
  end

  test "should create g_checklist_veiculo" do
    assert_difference("GChecklistVeiculo.count") do
      post g_checklists_veiculos_url, params: { g_checklist_veiculo: { g_estado_conservacao_veiculo_id: @g_checklist_veiculo.g_estado_conservacao_veiculo_id, g_tipo_item_checklist_veiculo_id: @g_checklist_veiculo.g_tipo_item_checklist_veiculo_id, g_vistoria_veiculo_id: @g_checklist_veiculo.g_vistoria_veiculo_id, observacao: @g_checklist_veiculo.observacao, resultado: @g_checklist_veiculo.resultado } }
    end

    assert_redirected_to g_checklist_veiculo_url(GChecklistVeiculo.last)
  end

  test "should show g_checklist_veiculo" do
    get g_checklist_veiculo_url(@g_checklist_veiculo)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_checklist_veiculo_url(@g_checklist_veiculo)
    assert_response :success
  end

  test "should update g_checklist_veiculo" do
    patch g_checklist_veiculo_url(@g_checklist_veiculo), params: { g_checklist_veiculo: { g_estado_conservacao_veiculo_id: @g_checklist_veiculo.g_estado_conservacao_veiculo_id, g_tipo_item_checklist_veiculo_id: @g_checklist_veiculo.g_tipo_item_checklist_veiculo_id, g_vistoria_veiculo_id: @g_checklist_veiculo.g_vistoria_veiculo_id, observacao: @g_checklist_veiculo.observacao, resultado: @g_checklist_veiculo.resultado } }
    assert_redirected_to g_checklist_veiculo_url(@g_checklist_veiculo)
  end

  test "should destroy g_checklist_veiculo" do
    assert_difference("GChecklistVeiculo.count", -1) do
      delete g_checklist_veiculo_url(@g_checklist_veiculo)
    end

    assert_redirected_to g_checklists_veiculos_url
  end
end
