import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masar/module/e_receipt/cubit/e_receipt_cubit.dart';
import 'package:masar/module/e_receipt/cubit/e_receipt_state.dart';
import 'package:masar/shared/class/handling_data_requst.dart';
import 'package:masar/shared/components/components/e_receipt_component.dart';
import '../../shared/components/components/shared_component.dart';

class EReceipt extends StatelessWidget {
  const EReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    final map = ModalRoute.of(context)!.settings.arguments as Map;

    return BlocProvider(
      create: (context) => EReceiptCubit(receiptID: "${map['id']}"),
      child: BlocConsumer<EReceiptCubit, EReceiptState>(
        listener: (context, state) {

        },
        builder: (context, state) {
        EReceiptCubit cubit=EReceiptCubit.get(context);
          return Scaffold(
            appBar: defaultAppbar(title: "ايصال الاكتروني", context: context),
            body: Container(
              margin: EdgeInsets.all(20),
              child: 
              HandlingDataRequst(
                statusRequest: cubit.statusRequest,
                widget: SingleChildScrollView(
                  child: Column(
                    children: [
                      customCardEReceipt(children: [
                        buildRowText(
                            textOne: "الاسم", textTwo: "${cubit.receiptDetails.firstName} ${cubit.receiptDetails!.lastName}"),
                        SizedBox(height: 10),
                        buildRowText(textOne: "رقم الهاتف", textTwo: "${cubit.receiptDetails!.phone}"),
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      customCardEReceipt(children: [
                        buildRowText(textOne: "النوع", textTwo: "${cubit.receiptDetails!.type}"),
                        SizedBox(height: 10),
                        buildRowText(textOne: "اسم الايصال", textTwo: "${cubit.receiptDetails!.name}"),
                       // SizedBox(height: 10),
                      //  buildRowText(textOne: "Category", textTwo: "${cubit.receiptDetails.}"),
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      customCardEReceipt(children: [
                        buildRowText(textOne: "رقم الايصال", textTwo: "${cubit.receiptDetails!.id}"),
                        SizedBox(height: 10),
                        buildRowText(textOne: "السعر", textTwo: "${cubit.receiptDetails!.amount}\$"),
                      //  SizedBox(height: 10),
                        // buildRowText(
                        //     textOne: "Price Before Discount", textTwo: "600\$"),
                        // SizedBox(height: 10),
                        // buildRowText(textOne: "Discount Value", textTwo: "100\$"),
                        SizedBox(height: 10),
                        buildRowText(
                            textOne: "التاريخ",
                            textTwo: "${cubit.receiptDetails!.date}"),
                        SizedBox(height: 15),
                        buildRowTextAndButton(
                            textOne: "الحالة", textButton: "${cubit.receiptDetails!.status}")
                      ]),
                    ],
                  ),
                ),
              ),
            
            ),
          );
        },
      ),
    );
  }
}
