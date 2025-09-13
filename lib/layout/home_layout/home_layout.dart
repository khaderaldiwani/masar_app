import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/layout/home_layout/cubit/home_layout_cubit.dart';
import 'package:masar/layout/home_layout/cubit/home_layout_states.dart';

class HomeLayout extends StatelessWidget {
 HomeLayout({super.key});

//  static var context;
 final _appLifecycleListener = AppLifecycleListener(
    onResume: () {
      print("object");
      // لما التطبيق يرجع من الخلفية
   //   HomeLayoutCubit.instance?.getDataNoti();
  //    HomeLayoutCubit.get(context)..getDataNoti();
    },
  );
  @override
  Widget build(BuildContext context) {
 
    HomeLayoutCubit cubit = HomeLayoutCubit.get(context)..getDataNoti();
     
    return BlocConsumer<HomeLayoutCubit, HomeLayoutState>(
          listener: (context, state) {},
          builder: (context, state) {
     
    return Scaffold(
    appBar: cubit.listappBar(context)[cubit.currentIndexBottomNavBar] ,//cubit.appBar[cubit.currentIndexBottomNavBar],
    bottomNavigationBar:BottomNavigationBar(
    items:cubit.items,
    currentIndex: cubit.currentIndexBottomNavBar, 
    onTap: (index){
     cubit.changeBottomNavBar(index);
    },
    ),
    body: cubit.pages[cubit.currentIndexBottomNavBar],
            );
          },
        );
    
  
  }
}
