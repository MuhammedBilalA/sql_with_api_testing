import 'package:flutter/material.dart';


import 'package:sql_with_api_testing/src/data/datasources/local/database_functions.dart';

import 'package:sql_with_api_testing/src/domain/models/local_model_class/local_model_class.dart';

class HomeScreen extends StatelessWidget {
 const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('API Test'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<LocalModelClass>>(
              future: DataBaseFunctions().addDetails(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name : ${snapshot.data![index].name}"),
                                Text('Email : ${snapshot.data![index].email}'),
                              ],
                            ),
                            subtitle: Text('Body : ${snapshot.data![index].body}'),
                            contentPadding:
                                const EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 25),
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
                        itemCount: snapshot.data!.length)
                    : snapshot.hasError
                        ? const Center(
                            child: Text('Something went wrong'),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
              }),
        ));
  }
}
