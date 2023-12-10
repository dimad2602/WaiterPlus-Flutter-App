class AppConstants{
  static const String CART_LIST="cart-list";
  static const String TOTAL_ITEMS_IN_CART="total-items-in-cart";
  static const String CART_HISTORY_LIST="cart-history-list";
  static const String RESTAURANT_CART_HISTORY_LIST="restaurant_cart-history-list";

  //TODO: Не заменил
  static const String CART_LIST_SQL="cart-list";
  static const String TOTAL_ITEMS_IN_CART_SQL="total-items-in-cart";
  static const String CART_HISTORY_LIST_SQL="cart-history-list";
  static const String RESTAURANT_CART_HISTORY_LIST_SQL="restaurant_cart-history-list";

  static const String SELECTED_RESTAURANT_ID="selected_reservation_id";

  static const String BASE_URL="http://";


  //Restaurants
  static const String RESTAURANT_LIST ="10.0.2.2:3000/restaurants"; //localhost указывать нельзя!!! если использую эмулятор
  static const String RESTAURANTS_BY_ID="10.0.2.2:3000/restaurants/";

  //Order
  static const String PLACE_ORDER_URI ="10.0.2.2:3000/orders";
  static const String ORDER_LIST_URI = "10.0.2.2:3000/orders"; //"10.0.2.2:3000/orders/list";

  //Auth Api
  //user and auth end points
  static const String REGISTRATION_URI="10.0.2.2:3000/auth/signup";
  static const String AUTH_LOGIN_URI="10.0.2.2:3000/auth/login";
  static const String AUTH_LOGOUT_URI="10.0.2.2:3000/auth/logout";
  static const String USER_INFO_URI="10.0.2.2:3000/users/info";

  static const String REFRESH_TOKEN_URI="10.0.2.2:3000/auth/refresh";


  static const String TOKEN=""; //DBtoken - вроде нудно пустым оставлять?
  static const String EXPIRATION_TOKEN="expiration_token";
  static const String PHONE="phone";
  static const String MAIL="mail";
  static const String PASSWORD="password";

  //GEO
  static const String USER_ADDRESS="user_address";
  static const String GEOCODE_URI ="/api/v1/config/geocode-api";
}