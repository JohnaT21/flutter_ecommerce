part of 'sell_bloc.dart';

abstract class SellEvent extends Equatable {
  const SellEvent();

  @override
  List<Object> get props => [];
}

class GetProductCategoryEvent extends SellEvent {
  const GetProductCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetRegionsEvent extends SellEvent {
  const GetRegionsEvent();

  @override
  List<Object> get props => [];
}

class AddProductEvent extends SellEvent {
  final pm.AddProductModel addProductModel;
  const AddProductEvent({required this.addProductModel});

  @override
  List<Object> get props => [];
}

class AddProductImageEvent extends SellEvent {
  final List<XFile>? formData;
  final String pId;
  const AddProductImageEvent({
    required this.formData,
    required this.pId,
  });

  @override
  List<Object> get props => [];
}



// class ChangeValueEvent extends SellEvent {
//   final List<res.Value> values;
//   const ChangeValueEvent({required this.values});

//   @override
//   List<Object> get props => [];
// }
