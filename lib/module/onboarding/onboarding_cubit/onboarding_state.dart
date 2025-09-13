import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

sealed class OnboardingState extends Equatable{
  final int currentPage;

  OnboardingState(this.currentPage);
  @override
  List<Object?> get props => [currentPage];
  
}

 class OnboardingStateInit extends OnboardingState{
  OnboardingStateInit(super.currentPage);
}
 class OnboardingStateChange extends OnboardingState{
  OnboardingStateChange(super.currentPage);
  
}