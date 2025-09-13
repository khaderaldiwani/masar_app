import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/onboarding/onboarding_cubit/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit():super(OnboardingStateInit(0));
     static OnboardingCubit get(BuildContext context)=>BlocProvider.of(context);
  next(){
  emit(OnboardingStateChange(state.currentPage+1)) ;
  }

  changePage(int pageNumber){
 emit(OnboardingStateChange(pageNumber))   ;
  }
  
}