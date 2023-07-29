import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_final_project/core/string_manager.dart';
import 'package:iti_final_project/screens/login_screen/view.dart';
import '../../../../core/values_manager.dart';
import '../../../core/components/elevated_button.dart';
import '../../../core/helper_method.dart';
import '../on_boarding_cubit.dart';
import 'dots.dart';

class CustomConstSlider extends StatelessWidget {
  const CustomConstSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = OnBoardingCubit.get(context);
        return Column(
          children: [
            const Dots(),
            Padding(
              padding: EdgeInsets.only(top: AppPadding.p40),
              child: CustomElevatedButton(
                  name:cubit.onLastPage()?StringManager.getStart: StringManager.next,
                  function: () {
                    if (cubit.onLastPage()) {
                      navigatorTo(context: context, page: const LoginScreen());
                    } else {
                      cubit.next();
                    }
                  }),
            ),
          ],
        );
      },
    );
  }
}
