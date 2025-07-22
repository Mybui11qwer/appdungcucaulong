class ApiConstants {
  // ignore: constant_identifier_names
  static const IPUrl = '192.168.4.10';
  static const baseUrl = 'http://$IPUrl:3000/api';
  //auth
  static const login = '$baseUrl/login';
  static const register = '$baseUrl/register';

  //product
  static const products = '$baseUrl/products';
  static String productDetail(int id) => '$products/$id';

  //cart
  static const getCart = '$baseUrl/cart';
  static const addToCart = '$baseUrl/cart/add';
  static const updateCartQuantity = '$baseUrl/cart/updateQuantity';
  static const removeFromCart = '$baseUrl/cart/remove';

  //profile
  static const userProfile = '$baseUrl/user/profile';

  // order
  static const orders = '$baseUrl/order';
  static String ordersByCustomer(int customerId) => '$orders/customer/$customerId';
  static String orderDetail(int orderId) => '$orders/$orderId';
}