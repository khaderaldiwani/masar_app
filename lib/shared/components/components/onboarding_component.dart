import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/onboarding/onboarding_cubit/onboarding_cubit.dart';
import 'package:masar/module/onboarding/onboarding_cubit/onboarding_state.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/network/local/static.dart';
import 'package:masar/shared/components/constant/app_route.dart';


  
  Widget customAnimateOnboarding() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(listOnboardingModel.length, (index) {
          return BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 12,
                width: index == state.currentPage ? 25 : 12,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                    color: index == state.currentPage
                        ? AppColor.primaryColor
                        : AppColor.grey,
                    borderRadius: BorderRadius.circular(20)),
              );
            },
          );
        })
      ],
    );
  }

  Widget customButtonOnboarding({required PageController pageController,required OnboardingCubit cubit,required BuildContext context}) {
    return Container(
      width: double.infinity,
      height: 40,
     // margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          cubit.next();
          if (cubit.state.currentPage >
              listOnboardingModel.length - 1) {
            Navigator.pushNamed(context, AppRoute.login);
          } else {
            pageController.animateToPage(
                cubit.state.currentPage,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          }
        },
        color: AppColor.primaryColor,
        child: const Text(
          "Continue",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }


  Widget customSliderOnboarding({required PageController pageController,required OnboardingCubit cubit}) {
    return PageView.builder(
      controller: pageController,
      onPageChanged: (val) {
        cubit.changePage(val);
      },
      itemCount: listOnboardingModel.length,
      itemBuilder: (context, index) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                listOnboardingModel[index].image!,
                height: 320,
                width: 320,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  listOnboardingModel[index].title!,
                  textAlign: TextAlign.center,
                  
                  style:
                       TextStyle(fontSize: 20,
                       fontWeight: FontWeight.bold,
                       color: AppColor.primaryColor
                       ),
                ),
              ),
               SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  listOnboardingModel[index].body!,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 18,
                       fontWeight: FontWeight.bold,
                       color:AppColor.black
                       ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

