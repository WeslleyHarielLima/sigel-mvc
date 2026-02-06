require "test_helper"

class AStatusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @a_status = a_status(:one)
  end

  test "should get index" do
    get a_status_index_url
    assert_response :success
  end

  test "should get new" do
    get new_a_status_url
    assert_response :success
  end

  test "should create a_status" do
    assert_difference("AStatus.count") do
      post a_status_index_url, params: { a_status: { descricao: @a_status.descricao } }
    end

    assert_redirected_to a_status_url(AStatus.last)
  end

  test "should show a_status" do
    get a_status_url(@a_status)
    assert_response :success
  end

  test "should get edit" do
    get edit_a_status_url(@a_status)
    assert_response :success
  end

  test "should update a_status" do
    patch a_status_url(@a_status), params: { a_status: { descricao: @a_status.descricao } }
    assert_redirected_to a_status_url(@a_status)
  end

  test "should destroy a_status" do
    assert_difference("AStatus.count", -1) do
      delete a_status_url(@a_status)
    end

    assert_redirected_to a_status_index_url
  end
end
