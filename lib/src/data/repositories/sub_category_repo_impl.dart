import 'package:ecommerce/src/data/data_sources/sub_category_datasource.dart';
import 'package:ecommerce/src/domain/repositories/sub_category_repo.dart';

import '../../core/network/network_info.dart';

class SubCategoryRepoImpl extends SubCategoryRepo {
  final NetworkInfo networkInfo;
  SubCategoryDataSource subCategoryDataSource;
  SubCategoryRepoImpl({required this.networkInfo, required this.subCategoryDataSource});
  @override
  Future<dynamic> getSubCategories(String categoryId) async {
    if (await networkInfo.isConnected) {
      return await subCategoryDataSource.getSubCategories(categoryId);
    } else {
      return "Please check your connection!";
    }
  }
}
