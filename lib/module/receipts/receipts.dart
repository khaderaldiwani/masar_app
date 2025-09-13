import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:masar/module/receipts/cubit/receipts_cubit.dart';
import 'package:masar/module/receipts/cubit/receipts_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/constant/app_color.dart';
import 'package:masar/shared/components/constant/app_route.dart';
import '../../shared/components/components/receipts_component.dart';
import '../../shared/components/components/shared_component.dart';

class Receipts extends StatelessWidget {
  const Receipts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceiptsCubit(),
      child: BlocConsumer<ReceiptsCubit, ReceiptsState>(
        listener: (context, state) {},
        builder: (context, state) {
          ReceiptsCubit cubit = ReceiptsCubit.get(context);
          return Container(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Expanded(
                          child: defaultButton(
                        title: "المدفوعات",
                        isActiv: cubit.isOngoing,
                        onTap: () {
                          cubit.changeOngoing(true);
                        },
                      )),
                      Expanded(
                          child: defaultButton(
                        title: "المرتجعات",
                        isActiv: !cubit.isOngoing,
                        onTap: () {
                          cubit.changeOngoing(false);
                        },
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //////////////////

                cubit.isOngoing
                    ? HandlingDataRequst(
                        statusRequest: cubit.statusRequestPaid,
                        textNodata: "لا يوجد ايصالات مدفوعة",
                        widget: cubit.listReceiptsPaymented.isEmpty
                            ? SizedBox(
                                height: 250,
                                child: handlinNoData(
                                    textNodata: "لا يوجد ايصالات مدفوعة"),
                              )
                            : AnimationLimiter(
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        duration: const Duration(seconds: 20),
                                        delay:
                                            const Duration(milliseconds: 200),
                                        child: SlideAnimation(
                                          verticalOffset:
                                              100, // 👈 العناصر تجي من أسفل
                                          curve: Curves.easeOutCubic,
                                          child: FadeInAnimation(
                                              child: buildReceiptsPaymentItem(
                                                  model: cubit
                                                          .listReceiptsPaymented[
                                                      index],
                                                  onTab: () {
                                                    Navigator.pushNamed(context,
                                                        AppRoute.eReceipt,
                                                        arguments: {
                                                          'id':
                                                              "${cubit.listReceiptsPaymented[index].id}"
                                                        });
                                                  })),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 1),
                                    itemCount:
                                        cubit.listReceiptsPaymented.length),
                              ),
                      )
                    ////////////
                    : cubit.listReceiptsNoPaymented.isEmpty
                        ? SizedBox(
                            height: 250,
                            child: handlinNoData(
                                textNodata: "لا يوجد ايصالات مرتجعة"),
                          )
                        : AnimationLimiter(
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(seconds: 20),
                                    delay: const Duration(milliseconds: 200),
                                    child: SlideAnimation(
                                      verticalOffset:
                                          100, // 👈 العناصر تجي من أسفل
                                      curve: Curves.easeOutCubic,
                                      child: FadeInAnimation(
                                          child: buildReceiptsPaymentItem(
                                              model:
                                                  cubit.listReceiptsNoPaymented[
                                                      index],
                                              onTab: () {
                                                Navigator.pushNamed(
                                                    context, AppRoute.eReceipt,
                                                    arguments: {
                                                      'id':
                                                          "${cubit.listReceiptsPaymented[index].id}"
                                                    });
                                              })),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 1),
                                itemCount:
                                    cubit.listReceiptsNoPaymented.length),
                          )
              ],
            ),
          );
        },
      ),
    );
  }
}
