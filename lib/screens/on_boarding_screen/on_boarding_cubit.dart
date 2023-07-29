import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/on_boarding_model.dart';
part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(OnBoardingInitialState());

  static OnBoardingCubit get(context) => BlocProvider.of(context);
  var pageController = PageController();
  int currentPage = 0;
  bool? isLastPage;
  BuildContext? context;

  next() {
    currentPage++;
    pageController.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    emit(OnBoardingNextPageState());
  }

  onPageChanged(int index) {
    currentPage = index;
    emit(OnBoardingChangePageState());
  }

  onLastPage() {
    if (currentPage == onBoardingList.length - 1) {
      return true;
    } else {
      return false;
    }
  }
}
