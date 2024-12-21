import 'package:ecommerce/src/domain/repositories/category_repo.dart';

class HomeCategory {
  CategoryRepo categoryRepo;
  HomeCategory({required this.categoryRepo});

  Future<dynamic> getAllCategories() async {
    return await categoryRepo.getAllCategories();
  }
}
