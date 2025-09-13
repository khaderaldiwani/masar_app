import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/home/cubit/home_cubit.dart';
import 'package:masar/module/search/cubit/search_cubit.dart';
import 'package:masar/module/search/cubit/search_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/home_components.dart';
import 'package:masar/shared/components/components/search_component.dart';
import 'package:masar/shared/components/components/shared_component.dart';
import 'package:masar/shared/components/constant/app_route.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit =HomeCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SearchCubit(),
          child: BlocConsumer<SearchCubit, SearchState>(
            listener: (context, state) {},
            builder: (context, state) {
              SearchCubit cubit = SearchCubit.get(context);
              return Container(
                  padding: const EdgeInsets.all(10),
                  child: ListView(
                    children: [
                      customSearchField(
                        onPressedFilter: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return buildFilterSearch(cubit: cubit);
                          },
                        );
                      },
                      onChanged:(val) {
                        cubit.ChangeModeSearch(val);
                       if(cubit.isSearch){
                        cubit.getData(val);
                       } 
                        
                      },
                    
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                     cubit.isSearch?
                     /////////////////////
                     Column(
                      children: [
                      
                      Row(
                        children: [
                          defaultHeadTitle(title: "نتائج البحث..."),
                          Spacer(),
                          buildButtonOrderBy(title: "ترتيب حسب",onTap: (){
                          showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return buildOrderBySearch(cubit: cubit);
                          },
                        );
                          })
                        ],
                        
                      ),
                      const SizedBox(height: 20),
                      HandlingDataRequst(
                        statusRequest: cubit.statusRequest,
                        textNodata: "لا يوجد نتائج مطابقة",
                       widget: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                  return buildCourseDetails(model: cubit.courses[index],context: context);
                    
                },
                 separatorBuilder: (context, index) =>SizedBox(height: 1) ,
                 itemCount:cubit.courses.length
                 ),
                     
                       )
                
                     ]
                     )
                     :
                     ///////////////
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      defaultHeadTitle(title: "تخصصات"),
                      const SizedBox(
                        height: 10,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.2,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0),
                        itemCount: homeCubit.categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildCategoriesSearchItem(
                            onTap: () {
                               Navigator.pushNamed(
                                  context,
                                  AppRoute.courses,
                                  arguments: index,
                                );
                            },
                          model:homeCubit.categories[index]
                           );
                        },
                      ),
                      ],
                      )
                  
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }
}
