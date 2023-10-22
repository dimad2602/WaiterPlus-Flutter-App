class AppConstants{
  static const String CART_LIST="cart-list";
  static const String TOTAL_ITEMS_IN_CART="total-items-in-cart";
  static const String CART_HISTORY_LIST="cart-history-list";
  static const String RESTAURANT_CART_HISTORY_LIST="restaurant_cart-history-list";

  static const String SELECTED_RESTAURANT_ID="selected_reservation_id";

  static const String BASE_URL="http://";
  //Restaurants
  static const String RESTAURANT_LIST ="10.0.2.2:3000/restaurants"; //localhost указывать нельзя!!! если использую эмулятор
  static const String RESTAURANTS="/api/v1/restaurants/"; // пример хорошего api

  //user and auth end points
  static const String REGISTRATION_URI="api/v1/auth/register";
  static const String LOGIN_URI="api/v1/auth/register";
  static const String USER_INFO_URI="api/v1/customer/info"; //info - это endpoint

  //GEO
  static const String USER_ADDRESS="user_address";
  static const String GEOCODE_URI ="/api/v1/config/geocode-api";

  static const String TOKEN=""; //DBtoken - вроде нудно пустым оставлять?
  static const String PHONE="";
  static const String PASSWORD="";



}