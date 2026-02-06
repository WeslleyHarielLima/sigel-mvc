require "test_helper"

class AUnidadesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @a_unidade = a_unidades(:one)
  end

  test "should get index" do
    get a_unidades_url
    assert_response :success
  end

  test "should get new" do
    get new_a_unidade_url
    assert_response :success
  end

  test "should create a_unidade" do
    assert_difference("AUnidade.count") do
      post a_unidades_url, params: { a_unidade: { a_orgao_id: @a_unidade.a_orgao_id, a_status_id: @a_unidade.a_status_id, cnpj: @a_unidade.cnpj, codigo_interno: @a_unidade.codigo_interno, endereco: @a_unidade.endereco, g_municipio_id: @a_unidade.g_municipio_id, nome_fantasia: @a_unidade.nome_fantasia, telefone: @a_unidade.telefone } }
    end

    assert_redirected_to a_unidade_url(AUnidade.last)
  end

  test "should show a_unidade" do
    get a_unidade_url(@a_unidade)
    assert_response :success
  end

  test "should get edit" do
    get edit_a_unidade_url(@a_unidade)
    assert_response :success
  end

  test "should update a_unidade" do
    patch a_unidade_url(@a_unidade), params: { a_unidade: { a_orgao_id: @a_unidade.a_orgao_id, a_status_id: @a_unidade.a_status_id, cnpj: @a_unidade.cnpj, codigo_interno: @a_unidade.codigo_interno, endereco: @a_unidade.endereco, g_municipio_id: @a_unidade.g_municipio_id, nome_fantasia: @a_unidade.nome_fantasia, telefone: @a_unidade.telefone } }
    assert_redirected_to a_unidade_url(@a_unidade)
  end

  test "should destroy a_unidade" do
    assert_difference("AUnidade.count", -1) do
      delete a_unidade_url(@a_unidade)
    end

    assert_redirected_to a_unidades_url
  end
end
