import 'package:flutter/material.dart';
import 'package:masar/module/onboarding/onboarding_cubit/onboarding_cubit.dart';
import 'package:masar/shared/components/components/onboarding_component.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
  OnboardingCubit cubit=OnboardingCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
           
            Expanded(
              flex: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 80,),
                  Expanded(
                    child: customSliderOnboarding(
                      pageController: pageController, cubit: cubit,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                   customAnimateOnboarding(),
                  const Spacer(),
                  customButtonOnboarding(
                    pageController: pageController, cubit:cubit ,context: context
                  ),
                  SizedBox(height: 25,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
