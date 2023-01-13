import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_expance/common_widget/button_widget.dart';
import 'package:money_expance/module/tabs/home/controller/expance_controller.dart';
import 'package:money_expance/utilies/constant.dart';

String? selectedValue1;

class AddTransationScreen extends StatefulWidget {
  const AddTransationScreen({Key? key}) : super(key: key);

  @override
  State<AddTransationScreen> createState() => _AddTransationScreenState();
}

class _AddTransationScreenState extends State<AddTransationScreen> {
  ExpanceController expanceController = Get.put(ExpanceController());
  final RxList<String> items = [
    'Shopping',
    'Subscription',
    'Food',
    'Salary',
    'Transportation',
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.red100,
      appBar: AppBar(
        backgroundColor: AppColors.red100,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                AppIcon.arrowLeft,
                color: AppColors.white,
              )),
        ),
        centerTitle: true,
        title: const Text(
          'Expense',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15.0, top: 25),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'How much?',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 4.0,
              ),
              child: TextFormField(
                controller: expanceController.moneyController,
                textAlignVertical: TextAlignVertical.top,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white),
                cursorColor: AppColors.white,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Enter Your Amount",
                    hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white)),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.60,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: const Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.lite20,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              items: items
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black100,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: selectedValue1,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue1 = value!;
                                });
                              },
                              icon: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 10, bottom: 10),
                                child: Image.asset(
                                  AppIcon.arrowDown,
                                  color: AppColors.lite20,
                                ),
                              ),
                              iconSize: 10,
                              iconEnabledColor: AppColors.black50,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonWidth: 160,
                              buttonPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: AppColors.lite20.withOpacity(0.40),
                                ),
                                color: AppColors.white,
                              ),
                              buttonElevation: 0,
                              itemHeight: 40,
                              itemPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              dropdownMaxHeight: 200,
                              dropdownPadding: null,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: AppColors.white,
                              ),
                              dropdownElevation: 8,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 15),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              minLines: 1,
                              maxLines: null,
                              textCapitalization: TextCapitalization.none,
                              controller: expanceController.desciption,
                              autocorrect: false,
                              scrollPadding:
                                  const EdgeInsets.symmetric(vertical: 5),
                              textAlign: TextAlign.start,
                              textInputAction: TextInputAction.done,
                              textAlignVertical: TextAlignVertical.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                  fillColor: AppColors.white,
                                  filled: true,
                                  hintText: "Description",
                                  hintStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.lite20,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.lite20
                                              .withOpacity(0.40))),
                                  border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.lite20
                                              .withOpacity(0.40))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: AppColors.lite20
                                              .withOpacity(0.40))),
                                  errorBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                      borderSide: BorderSide(width: 1, color: Colors.red))),
                            )),
                        expanceController.result == null
                            ? Container(
                                margin:
                                    const EdgeInsets.only(top: 15, bottom: 15),
                                height: 55,
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(12),
                                  color: AppColors.lite20.withOpacity(0.40),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.white)),
                                      onPressed: () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        showBottomSheet(
                                            context: context,
                                            expanceController:
                                                expanceController);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            AppIcon.attachment,
                                            height: 21,
                                            width: 21,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'Add attachment',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.lite20,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              )
                            : Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 25.0),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 120,
                                        width: expanceController
                                                    .result?.files[0].path
                                                    ?.split('/')
                                                    .last
                                                    .split('.')
                                                    .last ==
                                                'pdf'
                                            ? 100
                                            : 120,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: expanceController.result
                                                            ?.files[0].path
                                                            ?.split('/')
                                                            .last
                                                            .split('.')
                                                            .last ==
                                                        'pdf'
                                                    ? AppColors.lite20
                                                    : AppColors.white)),
                                        child: expanceController
                                                    .result?.files[0].path
                                                    ?.split('/')
                                                    .last
                                                    .split('.')
                                                    .last ==
                                                'pdf'
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    AppIcon.pdf,
                                                    height: 55,
                                                    width: 55,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '${expanceController.result?.files[0].name.toString()}',
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )
                                                ],
                                              )
                                            : Image.file(
                                                File(expanceController
                                                    .result!.files[0].path!),
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                      Positioned(
                                          right: -10,
                                          top: -8,
                                          child: GestureDetector(
                                              onTap: () {
                                                expanceController.result = null;
                                                setState(() {});
                                              },
                                              child: Image.asset(
                                                AppIcon.close,
                                                height: 25,
                                                width: 25,
                                              ))),
                                    ],
                                  ),
                                ),
                              ),
                        const Spacer(),
                        button(
                            text: 'Continue',
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              Get.dialog(Center(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Lottie.asset(AppIcon.success,
                                          height: 100, width: 100),
                                      const Text(
                                        'Transaction has been successfully added',
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.black100,
                                            decoration: TextDecoration.none),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                              expanceController.addDataToLocal();
                              expanceController.onInit();
                            },
                            context: context),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

showBottomSheet({context, ExpanceController? expanceController}) {
  showModalBottomSheet<void>(
    // context and builder are
    // required properties in this widget
    context: context,
    builder: (BuildContext context) {
      // we set up a container inside which
      // we create center column and display text

      // Returning SizedBox instead of a Container
      return ClipRRect(
        // borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24)),
        child: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 15),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
              // borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24))
              ),
          // height: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                height: 5,
                width: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.violet20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      expanceController?.result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.image,
                      );
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.violet20,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            AppIcon.camera,
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Camera',
                            style: TextStyle(
                                color: AppColors.violet100,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.violet20,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          AppIcon.gallery,
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Image',
                          style: TextStyle(
                              color: AppColors.violet100,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      expanceController?.result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      width: 100,
                      decoration: BoxDecoration(
                        color: AppColors.violet20,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            AppIcon.file,
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Document',
                            style: TextStyle(
                                color: AppColors.violet100,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
