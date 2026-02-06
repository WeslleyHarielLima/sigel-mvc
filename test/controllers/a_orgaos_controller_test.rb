require "test_helper"

class AOrgaosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @a_orgao = a_orgaos(:one)
  end

  test "should get index" do
    get a_orgaos_url
    assert_response :success
  end

  test "should get new" do
    get new_a_orgao_url
    assert_response :success
  end

  test "should create a_orgao" do
    assert_difference("AOrgao.count") do
      post a_orgaos_url, params: { a_orgao: { descricao: @a_orgao.descricao } }
    end

    assert_redirected_to a_orgao_url(AOrgao.last)
  end

  test "should show a_orgao" do
    get a_orgao_url(@a_orgao)
    assert_response :success
  end

  test "should get edit" do
    get edit_a_orgao_url(@a_orgao)
    assert_response :success
  end

  test "should update a_orgao" do
    patch a_orgao_url(@a_orgao), params: { a_orgao: { descricao: @a_orgao.descricao } }
    assert_redirected_to a_orgao_url(@a_orgao)
  end

  test "should destroy a_orgao" do
    assert_difference("AOrgao.count", -1) do
      delete a_orgao_url(@a_orgao)
    end

    assert_redirected_to a_orgaos_url
  end
end
