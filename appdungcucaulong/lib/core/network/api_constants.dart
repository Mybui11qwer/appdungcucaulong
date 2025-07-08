class ApiConstants {
  static const baseUrl = 'http://localhost:3000/api';

  //auth
  static const login = '$baseUrl/login';
  static const register = '$login/register';

  //product
  static const products = '$baseUrl/products';
  static String productDetail(int id) => '$products/$id';
}