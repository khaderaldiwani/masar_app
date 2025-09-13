import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/splash/splash_cubit.dart/nav_state.dart';
import 'package:masar/shared/components/constant/app_route.dart';

class NavCubit extends Cubit<NavState> {
  NavCubit():super(NavStateInit(AppRoute.splash));
goToOnboarding(BuildContext context){

  NavStateHome(AppRoute.onboarding); 
  Navigator.pushNamedAndRemoveUntil(context,AppRoute.onboarding,(route) => false,);
  
}
goToLogin(BuildContext context){

  NavStateHome(AppRoute.login); 
  Navigator.pushNamedAndRemoveUntil(context,AppRoute.login,(route) => false,);
  
}
goTohomeLayout(BuildContext context){

  NavStateHome(AppRoute.homeLayout); 
  Navigator.pushNamedAndRemoveUntil(context,AppRoute.homeLayout,(route) => false,);
  
}
  
}