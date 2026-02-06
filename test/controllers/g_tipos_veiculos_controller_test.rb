require "test_helper"

class GTiposVeiculosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_tipo_veiculo = g_tipos_veiculos(:one)
  end

  test "should get index" do
    get g_tipos_veiculos_url
    assert_response :success
  end

  test "should get new" do
    get new_g_tipo_veiculo_url
    assert_response :success
  end

  test "should create g_tipo_veiculo" do
    assert_difference("GTipoVeiculo.count") do
      post g_tipos_veiculos_url, params: { g_tipo_veiculo: { descricao: @g_tipo_veiculo.descricao } }
    end

    assert_redirected_to g_tipo_veiculo_url(GTipoVeiculo.last)
  end

  test "should show g_tipo_veiculo" do
    get g_tipo_veiculo_url(@g_tipo_veiculo)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_tipo_veiculo_url(@g_tipo_veiculo)
    assert_response :success
  end

  test "should update g_tipo_veiculo" do
    patch g_tipo_veiculo_url(@g_tipo_veiculo), params: { g_tipo_veiculo: { descricao: @g_tipo_veiculo.descricao } }
    assert_redirected_to g_tipo_veiculo_url(@g_tipo_veiculo)
  end

  test "should destroy g_tipo_veiculo" do
    assert_difference("GTipoVeiculo.count", -1) do
      delete g_tipo_veiculo_url(@g_tipo_veiculo)
    end

    assert_redirected_to g_tipos_veiculos_url
  end
end
