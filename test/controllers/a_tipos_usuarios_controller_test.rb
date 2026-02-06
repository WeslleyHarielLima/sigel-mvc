require "test_helper"

class ATiposUsuariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @a_tipo_usuario = a_tipos_usuarios(:one)
  end

  test "should get index" do
    get a_tipos_usuarios_url
    assert_response :success
  end

  test "should get new" do
    get new_a_tipo_usuario_url
    assert_response :success
  end

  test "should create a_tipo_usuario" do
    assert_difference("ATipoUsuario.count") do
      post a_tipos_usuarios_url, params: { a_tipo_usuario: { descricao: @a_tipo_usuario.descricao } }
    end

    assert_redirected_to a_tipo_usuario_url(ATipoUsuario.last)
  end

  test "should show a_tipo_usuario" do
    get a_tipo_usuario_url(@a_tipo_usuario)
    assert_response :success
  end

  test "should get edit" do
    get edit_a_tipo_usuario_url(@a_tipo_usuario)
    assert_response :success
  end

  test "should update a_tipo_usuario" do
    patch a_tipo_usuario_url(@a_tipo_usuario), params: { a_tipo_usuario: { descricao: @a_tipo_usuario.descricao } }
    assert_redirected_to a_tipo_usuario_url(@a_tipo_usuario)
  end

  test "should destroy a_tipo_usuario" do
    assert_difference("ATipoUsuario.count", -1) do
      delete a_tipo_usuario_url(@a_tipo_usuario)
    end

    assert_redirected_to a_tipos_usuarios_url
  end
end
