require "test_helper"

class GDistritosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_distrito = g_distritos(:one)
  end

  test "should get index" do
    get g_distritos_url
    assert_response :success
  end

  test "should get new" do
    get new_g_distrito_url
    assert_response :success
  end

  test "should create g_distrito" do
    assert_difference("GDistrito.count") do
      post g_distritos_url, params: { g_distrito: { codigo_ibge: @g_distrito.codigo_ibge, descricao: @g_distrito.descricao, g_municipio_id: @g_distrito.g_municipio_id } }
    end

    assert_redirected_to g_distrito_url(GDistrito.last)
  end

  test "should show g_distrito" do
    get g_distrito_url(@g_distrito)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_distrito_url(@g_distrito)
    assert_response :success
  end

  test "should update g_distrito" do
    patch g_distrito_url(@g_distrito), params: { g_distrito: { codigo_ibge: @g_distrito.codigo_ibge, descricao: @g_distrito.descricao, g_municipio_id: @g_distrito.g_municipio_id } }
    assert_redirected_to g_distrito_url(@g_distrito)
  end

  test "should destroy g_distrito" do
    assert_difference("GDistrito.count", -1) do
      delete g_distrito_url(@g_distrito)
    end

    assert_redirected_to g_distritos_url
  end
end
