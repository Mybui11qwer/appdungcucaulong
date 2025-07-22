class ApiConstants {
  static const baseUrl = 'http://192.168.1.81:3000/api';
  //auth
  static const login = '$baseUrl/login';
  static const register = '$baseUrl/register';

  //product
  static const products = '$baseUrl/products';
  static String productDetail(int id) => '$products/$id';

  //cart
  static const getCart = '$baseUrl/cart';
  static const addToCart = '$baseUrl/cart/add';
  static const removeFromCart = '$baseUrl/cart/remove';
}