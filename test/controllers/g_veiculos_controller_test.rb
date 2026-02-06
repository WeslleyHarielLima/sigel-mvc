require "test_helper"

class GVeiculosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_veiculo = g_veiculos(:one)
  end

  test "should get index" do
    get g_veiculos_url
    assert_response :success
  end

  test "should get new" do
    get new_g_veiculo_url
    assert_response :success
  end

  test "should create g_veiculo" do
    assert_difference("GVeiculo.count") do
      post g_veiculos_url, params: { g_veiculo: { ano: @g_veiculo.ano, chassi: @g_veiculo.chassi, cor: @g_veiculo.cor, g_status_veiculo_id: @g_veiculo.g_status_veiculo_id, marca: @g_veiculo.marca, modelo: @g_veiculo.modelo, motor: @g_veiculo.motor, numero_interno: @g_veiculo.numero_interno, placa: @g_veiculo.placa, renavam: @g_veiculo.renavam, tombamento: @g_veiculo.tombamento } }
    end

    assert_redirected_to g_veiculo_url(GVeiculo.last)
  end

  test "should show g_veiculo" do
    get g_veiculo_url(@g_veiculo)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_veiculo_url(@g_veiculo)
    assert_response :success
  end

  test "should update g_veiculo" do
    patch g_veiculo_url(@g_veiculo), params: { g_veiculo: { ano: @g_veiculo.ano, chassi: @g_veiculo.chassi, cor: @g_veiculo.cor, g_status_veiculo_id: @g_veiculo.g_status_veiculo_id, marca: @g_veiculo.marca, modelo: @g_veiculo.modelo, motor: @g_veiculo.motor, numero_interno: @g_veiculo.numero_interno, placa: @g_veiculo.placa, renavam: @g_veiculo.renavam, tombamento: @g_veiculo.tombamento } }
    assert_redirected_to g_veiculo_url(@g_veiculo)
  end

  test "should destroy g_veiculo" do
    assert_difference("GVeiculo.count", -1) do
      delete g_veiculo_url(@g_veiculo)
    end

    assert_redirected_to g_veiculos_url
  end
end
