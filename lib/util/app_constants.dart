class AppConstants{
  static const String CART_LIST="cart-list";
  static const String CART_HISTORY_LIST="cart-history-list";
  static const String RESTAURANT_CART_HISTORY_LIST="restaurant_cart-history-list";

  static const String SELECTED_RESTAURANT_ID="selected_reservation_id";

  static const String BASE_URL="http://";
  static const String RESTAURANTS="/api/v1/restaurants/";

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