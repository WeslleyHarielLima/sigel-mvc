require "application_system_test_case"

class ATipoUsuariosTest < ApplicationSystemTestCase
  setup do
    @a_tipo_usuario = a_tipos_usuarios(:one)
  end

  test "visiting the index" do
    visit a_tipos_usuarios_url
    assert_selector "h1", text: "A tipo usuarios"
  end

  test "should create a tipo usuario" do
    visit a_tipos_usuarios_url
    click_on "New a tipo usuario"

    fill_in "Descricao", with: @a_tipo_usuario.descricao
    click_on "Create A tipo usuario"

    assert_text "A tipo usuario was successfully created"
    click_on "Back"
  end

  test "should update A tipo usuario" do
    visit a_tipo_usuario_url(@a_tipo_usuario)
    click_on "Edit this a tipo usuario", match: :first

    fill_in "Descricao", with: @a_tipo_usuario.descricao
    click_on "Update A tipo usuario"

    assert_text "A tipo usuario was successfully updated"
    click_on "Back"
  end

  test "should destroy A tipo usuario" do
    visit a_tipo_usuario_url(@a_tipo_usuario)
    click_on "Destroy this a tipo usuario", match: :first

    assert_text "A tipo usuario was successfully destroyed"
  end
end
