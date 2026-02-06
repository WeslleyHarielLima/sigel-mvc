require "test_helper"

class GMarcasVeiculosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_marca_veiculo = g_marcas_veiculos(:one)
  end

  test "should get index" do
    get g_marcas_veiculos_url
    assert_response :success
  end

  test "should get new" do
    get new_g_marca_veiculo_url
    assert_response :success
  end

  test "should create g_marca_veiculo" do
    assert_difference("GMarcaVeiculo.count") do
      post g_marcas_veiculos_url, params: { g_marca_veiculo: { descricao: @g_marca_veiculo.descricao } }
    end

    assert_redirected_to g_marca_veiculo_url(GMarcaVeiculo.last)
  end

  test "should show g_marca_veiculo" do
    get g_marca_veiculo_url(@g_marca_veiculo)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_marca_veiculo_url(@g_marca_veiculo)
    assert_response :success
  end

  test "should update g_marca_veiculo" do
    patch g_marca_veiculo_url(@g_marca_veiculo), params: { g_marca_veiculo: { descricao: @g_marca_veiculo.descricao } }
    assert_redirected_to g_marca_veiculo_url(@g_marca_veiculo)
  end

  test "should destroy g_marca_veiculo" do
    assert_difference("GMarcaVeiculo.count", -1) do
      delete g_marca_veiculo_url(@g_marca_veiculo)
    end

    assert_redirected_to g_marcas_veiculos_url
  end
end
