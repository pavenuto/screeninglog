require 'test_helper'

class ScreeningsControllerTest < ActionController::TestCase
  setup do
    @screening = screenings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:screenings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create screening" do
    assert_difference('Screening.count') do
      post :create, screening: { date: @screening.date, rating: @screening.rating }
    end

    assert_redirected_to screening_path(assigns(:screening))
  end

  test "should show screening" do
    get :show, id: @screening
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @screening
    assert_response :success
  end

  test "should update screening" do
    patch :update, id: @screening, screening: { date: @screening.date, rating: @screening.rating }
    assert_redirected_to screening_path(assigns(:screening))
  end

  test "should destroy screening" do
    assert_difference('Screening.count', -1) do
      delete :destroy, id: @screening
    end

    assert_redirected_to screenings_path
  end
end
