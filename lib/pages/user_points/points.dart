import 'package:wg_pro_002/config/config.dart';

class PointsData {
  static List<Product> products = [
    Product(
        proImage: "${Config.BASE_APP_ASSETS_PATH}points_mall_product_01.png",
        name: "Kupon biaya bulanan gratis",
        points: 1000,
        value: "Biaya bulanan"),
    Product(
      proImage: "${Config.BASE_APP_ASSETS_PATH}points_mall_product_02.png",
      name: "10000 Kupon Pelunasan",
      points: 1000,
      value: "Rp10,000",
    ),
    Product(
        proImage: "${Config.BASE_APP_ASSETS_PATH}points_mall_product_03.png",
        name: "20000 Kupon Pelunasan",
        points: 1800,
        value: "Rp20,000"),
    Product(
        proImage: "${Config.BASE_APP_ASSETS_PATH}points_mall_product_04.png",
        name: "5000 Biaya Administrasi",
        points: 1000,
        value: "Rp5,000"),
    Product(
        proImage: "${Config.BASE_APP_ASSETS_PATH}points_mall_product_05.png",
        name: "Kupon Suku Bunga Deposito 0.1%",
        points: 2000,
        value: "0.1%"),
    Product(
        proImage: "${Config.BASE_APP_ASSETS_PATH}points_mall_product_06.png",
        name: "Kupon Suku Bunga Deposito 0.2%",
        points: 4000,
        value: "0.2%"),
  ];
}

class Product {
  final String name;
  final int points;
  final String value;
  final String proImage;

  Product(
      {required this.proImage,
      required this.name,
      required this.points,
      required this.value});
}
