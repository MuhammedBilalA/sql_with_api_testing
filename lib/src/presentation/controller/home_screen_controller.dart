import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_with_api_testing/src/data/datasources/local/database_functions.dart';
import 'package:sql_with_api_testing/src/domain/models/local_model_class/local_model_class.dart';

class HomeScreenController extends GetxController {
  List<LocalModelClass> apiLocalList = [];
  RxList<LocalModelClass> lazyLocalList = <LocalModelClass>[].obs;
  ScrollController scrollController = ScrollController();
  RxInt _currentMax = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    apiLocalList = await DataBaseFunctions().addDetails();
    _getMoreList();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        _getMoreList();
      }
    });
  }

  _getMoreList() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        for (int i = _currentMax.value; i < _currentMax.value + 10; i++) {
          lazyLocalList.add(apiLocalList[i]);
        }
        _currentMax += 10;
      },
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
