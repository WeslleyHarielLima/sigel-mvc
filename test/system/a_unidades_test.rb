require "application_system_test_case"

class AUnidadesTest < ApplicationSystemTestCase
  setup do
    @a_unidade = a_unidades(:one)
  end

  test "visiting the index" do
    visit a_unidades_url
    assert_selector "h1", text: "A unidades"
  end

  test "should create a unidade" do
    visit a_unidades_url
    click_on "New a unidade"

    fill_in "A orgao", with: @a_unidade.a_orgao_id
    fill_in "A status", with: @a_unidade.a_status_id
    fill_in "Cnpj", with: @a_unidade.cnpj
    fill_in "Codigo interno", with: @a_unidade.codigo_interno
    fill_in "Endereco", with: @a_unidade.endereco
    fill_in "G municipio", with: @a_unidade.g_municipio_id
    fill_in "Nome fantasia", with: @a_unidade.nome_fantasia
    fill_in "Telefone", with: @a_unidade.telefone
    click_on "Create A unidade"

    assert_text "A unidade was successfully created"
    click_on "Back"
  end

  test "should update A unidade" do
    visit a_unidade_url(@a_unidade)
    click_on "Edit this a unidade", match: :first

    fill_in "A orgao", with: @a_unidade.a_orgao_id
    fill_in "A status", with: @a_unidade.a_status_id
    fill_in "Cnpj", with: @a_unidade.cnpj
    fill_in "Codigo interno", with: @a_unidade.codigo_interno
    fill_in "Endereco", with: @a_unidade.endereco
    fill_in "G municipio", with: @a_unidade.g_municipio_id
    fill_in "Nome fantasia", with: @a_unidade.nome_fantasia
    fill_in "Telefone", with: @a_unidade.telefone
    click_on "Update A unidade"

    assert_text "A unidade was successfully updated"
    click_on "Back"
  end

  test "should destroy A unidade" do
    visit a_unidade_url(@a_unidade)
    click_on "Destroy this a unidade", match: :first

    assert_text "A unidade was successfully destroyed"
  end
end
