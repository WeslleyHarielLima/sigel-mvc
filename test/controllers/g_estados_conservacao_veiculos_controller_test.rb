require "test_helper"

class GEstadosConservacaoVeiculosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_estado_conservacao_veiculo = g_estados_conservacao_veiculos(:one)
  end

  test "should get index" do
    get g_estados_conservacao_veiculos_url
    assert_response :success
  end

  test "should get new" do
    get new_g_estado_conservacao_veiculo_url
    assert_response :success
  end

  test "should create g_estado_conservacao_veiculo" do
    assert_difference("GEstadoConservacaoVeiculo.count") do
      post g_estados_conservacao_veiculos_url, params: { g_estado_conservacao_veiculo: { descricao: @g_estado_conservacao_veiculo.descricao } }
    end

    assert_redirected_to g_estado_conservacao_veiculo_url(GEstadoConservacaoVeiculo.last)
  end

  test "should show g_estado_conservacao_veiculo" do
    get g_estado_conservacao_veiculo_url(@g_estado_conservacao_veiculo)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_estado_conservacao_veiculo_url(@g_estado_conservacao_veiculo)
    assert_response :success
  end

  test "should update g_estado_conservacao_veiculo" do
    patch g_estado_conservacao_veiculo_url(@g_estado_conservacao_veiculo), params: { g_estado_conservacao_veiculo: { descricao: @g_estado_conservacao_veiculo.descricao } }
    assert_redirected_to g_estado_conservacao_veiculo_url(@g_estado_conservacao_veiculo)
  end

  test "should destroy g_estado_conservacao_veiculo" do
    assert_difference("GEstadoConservacaoVeiculo.count", -1) do
      delete g_estado_conservacao_veiculo_url(@g_estado_conservacao_veiculo)
    end

    assert_redirected_to g_estados_conservacao_veiculos_url
  end
end
