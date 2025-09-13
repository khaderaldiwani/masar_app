import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/home/cubit/home_cubit.dart';
import 'package:masar/module/home/cubit/home_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/home_components.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_route.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     HomeCubit cubit = HomeCubit.get(context);
//     cubit.getData();
// //   HomeLayoutCubit homeLayoutCubit=HomeLayoutCubit.get(context);

//     return BlocConsumer<HomeCubit, HomeState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return HandlingDataRequst(
//             statusRequest: cubit.statusRequest,
//             widget: Container(
//               padding: const EdgeInsets.all(10),
//               child: RefreshIndicator(
//                 onRefresh: cubit.refresh,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       customSearchHome(onTap: () {
//                         Navigator.pushNamed(context, AppRoute.search);
//                         //   cubit.getData();
//                         //   homeLayoutCubit.getDataNoti();
//                       }),
//                       const SizedBox(height: 15),
//                       customAnnonPageView(cubit),
//                       const SizedBox(height: 5),
//                       customAnimatedContainer(cubit),
//                       const SizedBox(height: 10),
//                       customTitleHome(
//                           title: "أفضل المدرسين",
//                           endText: "كل المدرسين",
//                           onTap: () {
//                             Navigator.pushNamed(context, AppRoute.AllTeachers);
//                           }),
//                       const SizedBox(height: 20),
//                       SizedBox(
//                         height: 140,
//                         child: cubit.topTeachers.isEmpty
//                             ? handlinNoData(textNodata: "لا يوجد مدرسين ")
//                             : ListView.separated(
//                                 scrollDirection: Axis.horizontal,
//                                 itemBuilder: (context, index) {
//                                   return buildTeacherItem(
//                                     model: cubit.topTeachers[index],
//                                     onTap: () {
//                                       cubit.goToTeacherProfile(context,
//                                           "${cubit.topTeachers[index].id}");
//                                     },
//                                   );
//                                 },
//                                 separatorBuilder: (context, index) =>
//                                     const SizedBox(width: 15),
//                                 itemCount: cubit.topTeachers.length),
//                       ),
//                       customTitleHome(
//                           title: "تصفح حسب التخصص",
//                           endText: "كل التخصصات",
//                           onTap: () {
//                             Navigator.pushNamed(
//                                 context, AppRoute.AllCategories);
//                           }),
//                       const SizedBox(height: 35),
//                       SizedBox(
//                         height: 150,
//                         child: ListView(
//                           clipBehavior: Clip.none,
//                           scrollDirection: Axis.horizontal,
//                           children: [
//                             buildCategoryItemForAll(
//                                 text: "الكل",
//                                 onTap: () {
//                                   Navigator.pushNamed(
//                                       context, AppRoute.AllCourses);
//                                 }),
//                             //    buildCategoryItem(text: "موصى بها"),
//                             ListView.separated(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 clipBehavior: Clip.none,
//                                 scrollDirection: Axis.horizontal,
//                                 itemBuilder: (context, index) {
//                                   return buildCategoryItem(
//                                       model: cubit.categories[index],
//                                       onTap: () {
//                                         Navigator.pushNamed(
//                                           context,
//                                           AppRoute.courses,
//                                           arguments: index,
//                                         );
//                                       });
//                                 },
//                                 separatorBuilder: (context, index) =>
//                                     const SizedBox(width: 0),
//                                 itemCount: cubit.categories.length),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       customTitleHome(
//                           title: "الأعلى تقييماً",
//                           endText: "كل الدورات",
//                           onTap: () {
//                             Navigator.pushNamed(context, AppRoute.AllCourses);
//                           }),
//                       const SizedBox(height: 20),
//                       cubit.topCourses.isEmpty
//                           ? SizedBox(
//                               height: 150,
//                               child: handlinNoData(
//                                   textNodata:
//                                       "لا يوجد كورسات أعلى تقييماً حالياً"),
//                             )
//                           : ListView.separated(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemBuilder: (context, index) {
//                                 return buildCourseDetails(
//                                   context: context,
//                                   model: cubit.topCourses[index],
//                                 );
//                               },
//                               separatorBuilder: (context, index) =>
//                                   const SizedBox(height: 1),
//                               itemCount: cubit.topCourses.length),
//                     ],
//                   ),
//                 ),
//               ),
//             ));
//       },
//     );
//   }
// }


import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.get(context);
    cubit.getData();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return HandlingDataRequst(
          statusRequest: cubit.statusRequest,
          widget: Container(
            padding: const EdgeInsets.all(10),
            child: RefreshIndicator(
              onRefresh: cubit.refresh,
              child: SingleChildScrollView(
                child: AnimationLimiter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(seconds: 20),
                      delay: const Duration(milliseconds: 100),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        verticalOffset: 10,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        // --- البحث ---
                        customSearchHome(onTap: () {
                          Navigator.pushNamed(context, AppRoute.search);
                        }),
                        const SizedBox(height: 15),

                        // --- الاعلانات ---
                        customAnnonPageView(cubit),
                        const SizedBox(height: 5),
                        customAnimatedContainer(cubit),
                        const SizedBox(height: 10),

                        // --- أفضل المدرسين ---
                        customTitleHome(
                          title: "أفضل المدرسين",
                          endText: "كل المدرسين",
                          onTap: () {
                            Navigator.pushNamed(context, AppRoute.AllTeachers);
                          },
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 140,
                          child: cubit.topTeachers.isEmpty
                              ? handlinNoData(textNodata: "لا يوجد مدرسين ")
                              : ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final model = cubit.topTeachers[index];
                                    return buildTeacherItem(
                                      model: model,
                                      onTap: () {
                                        cubit.goToTeacherProfile(
                                            context, "${model.id}");
                                      },
                                    );
                                  },
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 15),
                                  itemCount: cubit.topTeachers.length,
                                ),
                        ),
                      //  const SizedBox(height: 1),

                        // --- التخصصات ---
                        customTitleHome(
                          title: "تصفح حسب التخصص",
                          endText: "كل التخصصات",
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoute.AllCategories);
                          },
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          height: 150,
                          child: ListView(
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            children: [
                              buildCategoryItemForAll(
                                  text: "الكل",
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoute.AllCourses);
                                  }),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final model = cubit.categories[index];
                                  return buildCategoryItem(
                                      model: model,
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoute.courses,
                                          arguments: index,
                                        );
                                      });
                                },
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 0),
                                itemCount: cubit.categories.length,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // --- الأعلى تقييماً ---
                        customTitleHome(
                          title: "الأعلى تقييماً",
                          endText: "كل الدورات",
                          onTap: () {
                            Navigator.pushNamed(context, AppRoute.AllCourses);
                          },
                        ),
                        const SizedBox(height: 20),
                        cubit.topCourses.isEmpty
                            ? SizedBox(
                                height: 150,
                                child: handlinNoData(
                                    textNodata:
                                        "لا يوجد كورسات أعلى تقييماً حالياً"),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final model = cubit.topCourses[index];
                                  return buildCourseDetails(
                                    context: context,
                                    model: model,
                                  );
                                },
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 10),
                                itemCount: cubit.topCourses.length,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
