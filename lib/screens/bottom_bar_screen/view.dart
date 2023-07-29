import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/screens/bottom_bar_screen/widgets/item_bottom_bar.dart';
import '../../../core/values_manager.dart';
import 'bottom_bar_cubit.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}
class _BottomBarScreenState extends State<BottomBarScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomBarCubit(),
      child: Builder(
          builder: (context) {
            final cubit = BottomBarCubit.get(context);
            return BlocConsumer<BottomBarCubit , BottomBarStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  extendBody: true,
                  body: cubit.pages[cubit.selectItem],
                  bottomNavigationBar: SizedBox(
                    height: 82,
                    child: BottomAppBar(

                      color: Colors.white,
                      shape: const CircularNotchedRectangle(),
                      notchMargin: AppMargin.m12,
                      child: Row(
                        children: List.generate(
                            cubit.title.length,
                                (index) =>
                                ItemBottomBar(
                                  isSelected: index == cubit.selectItem,
                                  text: cubit.title[index],
                                  icon: cubit.icons[index],
                                  onPress: () {
                              cubit.changeBottomBar(index);
                            })),
                      ),
                    ),
                  ),
                );
              },
            );
          }
      ),
    );
  }
}
