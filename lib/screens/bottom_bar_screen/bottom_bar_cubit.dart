import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iti_final_project/screens/category_screen/view.dart';
import '../../core/const.dart';
import '../add_products_screen/view.dart';
import '../app_info_screen/view.dart';
import '../home_screen/view.dart';
import '../profile_screen/view.dart';

part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarStates> {
  BottomBarCubit() : super(BottomBarInitial());

  static BottomBarCubit get(context) => BlocProvider.of(context);
  String? id;

  int selectItem = 0;

  List<String> title = [
    'Home',
    'Category',
    'Add',
    'Profile',
    'Details',
  ];
  List<IconData> icons = [
    Icons.home_filled,
    Icons.menu_open_rounded,
    Icons.add_task_outlined,
    FontAwesomeIcons.user,
    FontAwesomeIcons.info,
  ];

  final pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const AddProductsScreen(),
    ProfileScreen(userId:uid ),
    const AppDetails(),
  ];

  void changeBottomBar(index) {
    selectItem = index;
    emit(BottomBarChangePage());
  }
}
