import 'package:ecommerce/src/data/data_sources/categories_datasource.dart';
import 'package:ecommerce/src/domain/repositories/category_repo.dart';

import '../../core/network/network_info.dart';

class CategoryRepoImpl extends CategoryRepo {
  final CategoryDataSource categoryDataSource;
  final NetworkInfo networkInfo;
  CategoryRepoImpl({required this.networkInfo, required this.categoryDataSource});

  @override
  Future<dynamic> getAllCategories() async {
    if (await networkInfo.isConnected) {
      return await categoryDataSource.getAllCategories();
    } else {
      return "Please check your connection!";
    }
  }
}
