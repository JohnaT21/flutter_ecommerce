import 'package:ecommerce/src/domain/repositories/sub_category_repo.dart';

class HomeSubCateogry {
  SubCategoryRepo subCategoryRepo;
  HomeSubCateogry({required this.subCategoryRepo});
  Future<dynamic> getSubCategories(String subCategoryId) async {
    return subCategoryRepo.getSubCategories(subCategoryId);
  }
}
