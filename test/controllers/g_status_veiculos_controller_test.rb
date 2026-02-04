require "test_helper"

class GStatusVeiculosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_status_veiculo = g_status_veiculos(:one)
  end

  test "should get index" do
    get g_status_veiculos_url
    assert_response :success
  end

  test "should get new" do
    get new_g_status_veiculo_url
    assert_response :success
  end

  test "should create g_status_veiculo" do
    assert_difference("GStatusVeiculo.count") do
      post g_status_veiculos_url, params: { g_status_veiculo: { descricao: @g_status_veiculo.descricao } }
    end

    assert_redirected_to g_status_veiculo_url(GStatusVeiculo.last)
  end

  test "should show g_status_veiculo" do
    get g_status_veiculo_url(@g_status_veiculo)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_status_veiculo_url(@g_status_veiculo)
    assert_response :success
  end

  test "should update g_status_veiculo" do
    patch g_status_veiculo_url(@g_status_veiculo), params: { g_status_veiculo: { descricao: @g_status_veiculo.descricao } }
    assert_redirected_to g_status_veiculo_url(@g_status_veiculo)
  end

  test "should destroy g_status_veiculo" do
    assert_difference("GStatusVeiculo.count", -1) do
      delete g_status_veiculo_url(@g_status_veiculo)
    end

    assert_redirected_to g_status_veiculos_url
  end
end
