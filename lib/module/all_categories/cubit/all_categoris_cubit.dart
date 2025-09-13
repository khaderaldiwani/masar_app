import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/model/categories_model.dart';
import 'package:masar/module/all_categories/cubit/all_categoris_state.dart';
import 'package:masar/shared/function/handlingResponse.dart';
import 'package:masar/shared/network/local/cach_helper.dart';
import 'package:masar/shared/network/remote/data/all_categories_data.dart';
import 'package:masar/shared/network/remote/http_helper.dart';
import 'package:masar/shared/network/remote/status_requst.dart';

class AllCategoriesCubit extends Cubit<AllCategoriesState> {
  AllCategoriesCubit() : super(AllCategoriesInitial());
  static AllCategoriesCubit get(BuildContext context) =>
      BlocProvider.of(context);
  StatusRequest statusRequest = StatusRequest.none;
  AllCategoriesData allCategoriesData = AllCategoriesData(Api());

  List categories = [];

  getData() async {
    if (isClosed) return;
    statusRequest = StatusRequest.loading;
    if (!isClosed) emit(AllCategoriesSuccessState());
    String token = CachHelper.getString(key: "token")!;
    var response = await allCategoriesData.getData(token);
    statusRequest = handlingResponse(response);
    if (statusRequest == StatusRequest.success) {
      if (response['success'] == true) {
        categories = [];
        ///////////////////
        List categoriesResponse = response['data'];
        categories
            .addAll(categoriesResponse.map((e) => CategoriesModel.fromJson(e)));
        //////////////
        if (categories.isEmpty) {
          statusRequest = StatusRequest.failure;
        }
      }
      //  else {
      //   statusRequest = StatusRequest.failure;
      // }
    }
    //  else {
    //   statusRequest = StatusRequest.failure;
    // }
    if (!isClosed) emit(AllCategoriesFinishState());
  }

}
