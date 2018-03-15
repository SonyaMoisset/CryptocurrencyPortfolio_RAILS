require 'test_helper'

class CryptocurrenciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cryptocurrency = cryptocurrencies(:one)
  end

  test "should get index" do
    get cryptocurrencies_url
    assert_response :success
  end

  test "should get new" do
    get new_cryptocurrency_url
    assert_response :success
  end

  test "should create cryptocurrency" do
    assert_difference('Cryptocurrency.count') do
      post cryptocurrencies_url, params: { cryptocurrency: { amount_owned: @cryptocurrency.amount_owned, cost_per: @cryptocurrency.cost_per, symbol: @cryptocurrency.symbol, user_id: @cryptocurrency.user_id } }
    end

    assert_redirected_to cryptocurrency_url(Cryptocurrency.last)
  end

  test "should show cryptocurrency" do
    get cryptocurrency_url(@cryptocurrency)
    assert_response :success
  end

  test "should get edit" do
    get edit_cryptocurrency_url(@cryptocurrency)
    assert_response :success
  end

  test "should update cryptocurrency" do
    patch cryptocurrency_url(@cryptocurrency), params: { cryptocurrency: { amount_owned: @cryptocurrency.amount_owned, cost_per: @cryptocurrency.cost_per, symbol: @cryptocurrency.symbol, user_id: @cryptocurrency.user_id } }
    assert_redirected_to cryptocurrency_url(@cryptocurrency)
  end

  test "should destroy cryptocurrency" do
    assert_difference('Cryptocurrency.count', -1) do
      delete cryptocurrency_url(@cryptocurrency)
    end

    assert_redirected_to cryptocurrencies_url
  end
end
