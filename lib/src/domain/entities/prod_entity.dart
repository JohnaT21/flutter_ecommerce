import 'package:equatable/equatable.dart';

class ProdEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<String> imagesURL;

  const ProdEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imagesURL,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
