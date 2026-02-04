require "test_helper"

class GLocalidadesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_localidade = g_localidades(:one)
  end

  test "should get index" do
    get g_localidades_url
    assert_response :success
  end

  test "should get new" do
    get new_g_localidade_url
    assert_response :success
  end

  test "should create g_localidade" do
    assert_difference("GLocalidade.count") do
      post g_localidades_url, params: { g_localidade: { descricao: @g_localidade.descricao, g_distrito_id: @g_localidade.g_distrito_id } }
    end

    assert_redirected_to g_localidade_url(GLocalidade.last)
  end

  test "should show g_localidade" do
    get g_localidade_url(@g_localidade)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_localidade_url(@g_localidade)
    assert_response :success
  end

  test "should update g_localidade" do
    patch g_localidade_url(@g_localidade), params: { g_localidade: { descricao: @g_localidade.descricao, g_distrito_id: @g_localidade.g_distrito_id } }
    assert_redirected_to g_localidade_url(@g_localidade)
  end

  test "should destroy g_localidade" do
    assert_difference("GLocalidade.count", -1) do
      delete g_localidade_url(@g_localidade)
    end

    assert_redirected_to g_localidades_url
  end
end
