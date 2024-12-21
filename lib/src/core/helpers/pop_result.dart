import 'package:ecommerce/src/domain/entities/product_category.dart';
import 'package:ecommerce/src/domain/entities/add_product_model.dart' as pm;
import 'package:meta/meta.dart';

/// PopResult
class PopWithResults<T> {
  /// poped from this page
  final String fromPage;

  /// pop until this page
  final String toPage;

  /// results
  // final Map<String, T> results;
  final Subcategory? results;
  final List<pm.Option> option;
  final List<Values>? values;

  /// constructor
  PopWithResults({
    required this.fromPage,
    required this.toPage,
    required this.results,
    required this.option,
    this.values,
  });
}
