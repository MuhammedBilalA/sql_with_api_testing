import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_with_api_testing/src/presentation/controller/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeScreenController>();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('API Test'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            return ListView.separated(
                itemBuilder: (context, index) {
                  if (index == controller.lazyLocalList.length) {
                    return const Center(
                      child: CupertinoActivityIndicator(
                        radius: 20,
                        color: Colors.deepPurple,
                      ),
                    );
                  }
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name : ${controller.lazyLocalList[index].name}  + $index"),
                        Text('Email : ${controller.lazyLocalList[index].email}'),
                      ],
                    ),
                    subtitle: Text('Body : ${controller.lazyLocalList[index].body}'),
                    contentPadding: const EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 25),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.inversePrimary, width: 2)),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                controller: controller.scrollController,
                itemCount: controller.lazyLocalList.length + 1);
          }),
        ));
  }
}
