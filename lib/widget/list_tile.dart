import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/widget/text_field.dart';

import '../model/user.dart';
import '../providers/user_notifier.dart';
import 'button.dart';

class MyListTile extends StatelessWidget {
  final String name;
  final String city;
  List<User> userList;
  int index;
  int id;
  MyListTile(
      {Key? key,
      required this.name,
      required this.city,
      required this.userList,
      required this.index,
        required this.id
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listNotify = ListNotifier();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5.0,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          title: Text('Name: $name'),
          subtitle: Text('City: $city'),
          onTap: (){
             listNotify.singleUser = User();
             _showDialog(context,id,listNotify);
          },
        ),
      ),
    );
  }
  _showDialog(BuildContext context, int id, ListNotifier listNotifier) async {
    final dialogKey = GlobalKey<FormState>();
    String name = '';
    String city = '';
    return showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
              title: const Text('Update user info'),
              content: Form(
                key: dialogKey,
                child: Column(
                  children: [
                    MyTextField(
                      label: 'Name',
                      onSaved: (value) {
                        name = value!;
                      },
                    ),
                    MyTextField(
                      label: 'City',
                      onSaved: (value) {
                        city = value!;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                MyButton(
                  buttonText: 'Update',
                  onPressed: () {
                    if (dialogKey.currentState!.validate()) {
                      dialogKey.currentState!.save();
                      var user = User(name: name, city: city, id: id);
                      listNotifier.updateUserOfLocalDb(user);
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }



}
