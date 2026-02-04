require "test_helper"

class GStatusLeiloesVeiculosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_status_leilao_veiculo = g_status_leiloes_veiculos(:one)
  end

  test "should get index" do
    get g_status_leiloes_veiculos_url
    assert_response :success
  end

  test "should get new" do
    get new_g_status_leilao_veiculo_url
    assert_response :success
  end

  test "should create g_status_leilao_veiculo" do
    assert_difference("GStatusLeilaoVeiculo.count") do
      post g_status_leiloes_veiculos_url, params: { g_status_leilao_veiculo: { descricao: @g_status_leilao_veiculo.descricao } }
    end

    assert_redirected_to g_status_leilao_veiculo_url(GStatusLeilaoVeiculo.last)
  end

  test "should show g_status_leilao_veiculo" do
    get g_status_leilao_veiculo_url(@g_status_leilao_veiculo)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_status_leilao_veiculo_url(@g_status_leilao_veiculo)
    assert_response :success
  end

  test "should update g_status_leilao_veiculo" do
    patch g_status_leilao_veiculo_url(@g_status_leilao_veiculo), params: { g_status_leilao_veiculo: { descricao: @g_status_leilao_veiculo.descricao } }
    assert_redirected_to g_status_leilao_veiculo_url(@g_status_leilao_veiculo)
  end

  test "should destroy g_status_leilao_veiculo" do
    assert_difference("GStatusLeilaoVeiculo.count", -1) do
      delete g_status_leilao_veiculo_url(@g_status_leilao_veiculo)
    end

    assert_redirected_to g_status_leiloes_veiculos_url
  end
end
