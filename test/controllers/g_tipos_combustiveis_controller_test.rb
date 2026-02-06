require "test_helper"

class GTiposCombustiveisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_tipo_combustivel = g_tipos_combustiveis(:one)
  end

  test "should get index" do
    get g_tipos_combustiveis_url
    assert_response :success
  end

  test "should get new" do
    get new_g_tipo_combustivel_url
    assert_response :success
  end

  test "should create g_tipo_combustivel" do
    assert_difference("GTipoCombustivel.count") do
      post g_tipos_combustiveis_url, params: { g_tipo_combustivel: { descricao: @g_tipo_combustivel.descricao } }
    end

    assert_redirected_to g_tipo_combustivel_url(GTipoCombustivel.last)
  end

  test "should show g_tipo_combustivel" do
    get g_tipo_combustivel_url(@g_tipo_combustivel)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_tipo_combustivel_url(@g_tipo_combustivel)
    assert_response :success
  end

  test "should update g_tipo_combustivel" do
    patch g_tipo_combustivel_url(@g_tipo_combustivel), params: { g_tipo_combustivel: { descricao: @g_tipo_combustivel.descricao } }
    assert_redirected_to g_tipo_combustivel_url(@g_tipo_combustivel)
  end

  test "should destroy g_tipo_combustivel" do
    assert_difference("GTipoCombustivel.count", -1) do
      delete g_tipo_combustivel_url(@g_tipo_combustivel)
    end

    assert_redirected_to g_tipos_combustiveis_url
  end
end
