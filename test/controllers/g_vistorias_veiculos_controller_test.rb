require "test_helper"

class GVistoriasVeiculosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_vistoria_veiculo = g_vistorias_veiculos(:one)
  end

  test "should get index" do
    get g_vistorias_veiculos_url
    assert_response :success
  end

  test "should get new" do
    get new_g_vistoria_veiculo_url
    assert_response :success
  end

  test "should create g_vistoria_veiculo" do
    assert_difference("GVistoriaVeiculo.count") do
      post g_vistorias_veiculos_url, params: { g_vistoria_veiculo: { data_vistoria: @g_vistoria_veiculo.data_vistoria, g_veiculo_id: @g_vistoria_veiculo.g_veiculo_id, observacoes: @g_vistoria_veiculo.observacoes, user_id: @g_vistoria_veiculo.user_id } }
    end

    assert_redirected_to g_vistoria_veiculo_url(GVistoriaVeiculo.last)
  end

  test "should show g_vistoria_veiculo" do
    get g_vistoria_veiculo_url(@g_vistoria_veiculo)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_vistoria_veiculo_url(@g_vistoria_veiculo)
    assert_response :success
  end

  test "should update g_vistoria_veiculo" do
    patch g_vistoria_veiculo_url(@g_vistoria_veiculo), params: { g_vistoria_veiculo: { data_vistoria: @g_vistoria_veiculo.data_vistoria, g_veiculo_id: @g_vistoria_veiculo.g_veiculo_id, observacoes: @g_vistoria_veiculo.observacoes, user_id: @g_vistoria_veiculo.user_id } }
    assert_redirected_to g_vistoria_veiculo_url(@g_vistoria_veiculo)
  end

  test "should destroy g_vistoria_veiculo" do
    assert_difference("GVistoriaVeiculo.count", -1) do
      delete g_vistoria_veiculo_url(@g_vistoria_veiculo)
    end

    assert_redirected_to g_vistorias_veiculos_url
  end
end
