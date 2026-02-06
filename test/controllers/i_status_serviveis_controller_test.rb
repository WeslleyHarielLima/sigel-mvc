require "test_helper"

class IStatusServiveisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @i_status_servivel = i_status_serviveis(:one)
  end

  test "should get index" do
    get i_status_serviveis_url
    assert_response :success
  end

  test "should get new" do
    get new_i_status_servivel_url
    assert_response :success
  end

  test "should create i_status_servivel" do
    assert_difference("IStatusServivel.count") do
      post i_status_serviveis_url, params: { i_status_servivel: { descricao: @i_status_servivel.descricao } }
    end

    assert_redirected_to i_status_servivel_url(IStatusServivel.last)
  end

  test "should show i_status_servivel" do
    get i_status_servivel_url(@i_status_servivel)
    assert_response :success
  end

  test "should get edit" do
    get edit_i_status_servivel_url(@i_status_servivel)
    assert_response :success
  end

  test "should update i_status_servivel" do
    patch i_status_servivel_url(@i_status_servivel), params: { i_status_servivel: { descricao: @i_status_servivel.descricao } }
    assert_redirected_to i_status_servivel_url(@i_status_servivel)
  end

  test "should destroy i_status_servivel" do
    assert_difference("IStatusServivel.count", -1) do
      delete i_status_servivel_url(@i_status_servivel)
    end

    assert_redirected_to i_status_serviveis_url
  end
end
