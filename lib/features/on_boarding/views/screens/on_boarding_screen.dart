import 'package:autism/core/utilies/sizes/sized_config.dart';
import 'package:autism/features/auth/sign_in/views/widgets/sign_in_screen_body.dart';
import 'package:autism/features/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:autism/features/on_boarding/models/on_boarding_steps_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final PageController controller = PageController();

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: BlocBuilder<OnBoardingCubit, int>(
        builder: (context, state) {
          var cubit = context.read<OnBoardingCubit>();
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: SizeConfig.width * 0.05,
                      top: SizeConfig.width * 0.04,
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreenBody(),
                              ),
                            );
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 9,
                    child: PageView.builder(
                      controller: controller,
                      itemCount: steps.length,
                      onPageChanged: (index) {
                        cubit.changePage(index);
                      },
                      itemBuilder: (context, index) {
                        return steps[index];
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width * 0.04,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (state == steps.length - 1) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreenBody(),
                              ),
                            );
                          } else {
                            cubit.nextPage(state, steps.length, controller);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            bottom: SizeConfig.width * 0.04,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFFF7F3E),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                letterSpacing: -0.2,
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
