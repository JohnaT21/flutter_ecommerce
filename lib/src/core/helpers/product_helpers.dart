import '../../data/models/products_response_model.dart';

///filter Featured Products from fetched products
List<Product> filterFeaturedProducts({required List<Product> allProducts}) {
  List<Product> filtered =
      allProducts.where((product) => product.featured == true).toList();

  return filtered;
}

///filter product's usage state
String getProductState({required Product product}) {
  String condition = '';
  if (product.options.isNotEmpty) {
    for (var option in product.options) {
      if (option.optionId.name == "Condition") {
        condition = option.values[0].value;
      }
    }
  }
  return condition;
}
