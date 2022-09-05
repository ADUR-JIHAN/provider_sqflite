import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/providers/user_notifier.dart';
import 'package:provider_demo/widget/button.dart';
import 'package:provider_demo/widget/list_tile.dart';
import 'package:provider_demo/widget/list_view.dart';
import 'package:provider_demo/widget/text_field.dart';

import '../model/user.dart';

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _listNotify = Provider.of<ListNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Demo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _listNotify.formKey,
            child: Column(
              children: [
                MyTextField(
                    label: 'Name',
                    onSaved: (value) {
                      _listNotify.singleUser.name = value;
                    },
                  validator: (value) =>
                  value!.trim().isEmpty ? 'Name required' : null,

                    ),
                MyTextField(
                  label: 'City',
                  onSaved: (value) {
                    _listNotify.singleUser.city = value;
                  },
                  validator: (value) =>
                  value!.trim().isEmpty ? 'City required' : null,
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyButton(
                        buttonText: 'CLEAR',
                        onPressed: () {
                         // _listNotify.insertUser(_listNotify.singleUser);
                          _listNotify.clear();

                        }),
                    MyButton(buttonText: 'ADD TO DB',
                      onPressed: (){
                      final isValid = _listNotify.formKey.currentState!.validate();
                      if(isValid)  _listNotify.insertUserTOLocalDatabase(_listNotify.singleUser);
                      else {
                        print('Nothing to insert');
                      }
                      },
                    ),
                  ],
                ),
                MyListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
