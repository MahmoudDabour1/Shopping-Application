part of 'add_products_cubit.dart';

@immutable
abstract class AddProductsState {}

class AddProductsInitial extends AddProductsState {}
class AddProductsTakeImageState extends AddProductsState {}
class AddProductsTakeCategoryState extends AddProductsState {}
class AddProductsSuccessState extends AddProductsState {}
class AddProductsErrorState extends AddProductsState {}
class AddProductsLoadingState extends AddProductsState {}
