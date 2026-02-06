require "test_helper"

class IStatusInserviveisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @i_status_inservivel = i_status_inserviveis(:one)
  end

  test "should get index" do
    get i_status_inserviveis_url
    assert_response :success
  end

  test "should get new" do
    get new_i_status_inservivel_url
    assert_response :success
  end

  test "should create i_status_inservivel" do
    assert_difference("IStatusInservivel.count") do
      post i_status_inserviveis_url, params: { i_status_inservivel: { descricao: @i_status_inservivel.descricao } }
    end

    assert_redirected_to i_status_inservivel_url(IStatusInservivel.last)
  end

  test "should show i_status_inservivel" do
    get i_status_inservivel_url(@i_status_inservivel)
    assert_response :success
  end

  test "should get edit" do
    get edit_i_status_inservivel_url(@i_status_inservivel)
    assert_response :success
  end

  test "should update i_status_inservivel" do
    patch i_status_inservivel_url(@i_status_inservivel), params: { i_status_inservivel: { descricao: @i_status_inservivel.descricao } }
    assert_redirected_to i_status_inservivel_url(@i_status_inservivel)
  end

  test "should destroy i_status_inservivel" do
    assert_difference("IStatusInservivel.count", -1) do
      delete i_status_inservivel_url(@i_status_inservivel)
    end

    assert_redirected_to i_status_inserviveis_url
  end
end
