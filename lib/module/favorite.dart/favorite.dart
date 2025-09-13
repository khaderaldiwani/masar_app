import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:masar/module/favorite.dart/cubit/favorite_cubit.dart';
import 'package:masar/module/favorite.dart/cubit/favorite_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/home_components.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_route.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit()..getAllCoursesFavorite(),
      child: BlocConsumer<FavoriteCubit, FavoriteState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          FavoriteCubit cubit = FavoriteCubit.get(context);
          return Scaffold(
            appBar: defaultAppbar(
                title: "المفضلة",
                context: context,
                
                ),
            body: HandlingDataRequst(
              
              statusRequest: cubit.statusRequest,
              textNodata: "المفضلة فارغة",
              widget: Container(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    AnimationLimiter(
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(seconds: 20),
                          delay:const Duration(milliseconds: 200) ,
                          child: SlideAnimation(
                            verticalOffset: 100, // 👈 العناصر تجي من أسفل
                            curve: Curves.easeOutCubic,
                            child: FadeInAnimation(
                              child: buildCourseDetails(
                              context: context,
                              model: cubit.listFourses[index],
                              onPressed: (){
                              cubit.deleteFavorite("${cubit.listFourses[index].id}");
                              }
                            )
                            ),
                          ),
                        );
                            
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 1),
                          itemCount: cubit.listFourses.length),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
