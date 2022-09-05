import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/providers/user_notifier.dart';

import '../model/user.dart';
import 'list_tile.dart';

class MyListView extends StatelessWidget {
  

  MyListView({Key? key,}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<ListNotifier>(context);
    var size = MediaQuery.of(context).size;
    return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: notifier.list.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_){
                    User deleteItem = notifier.list[index];
                    //provider.deleteElement(index);
                    notifier.deleteFromDb(notifier.list[index].id!);
                    final snackBar=SnackBar(
                      content: Text("Deleted \"${deleteItem.name}\""),
                      action: SnackBarAction(
                          label:'undo',
                          onPressed: (){
                            notifier.undoUserToDb(deleteItem);
                          }) // this is what you needed
                      );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  background: Container(
                    color: Colors.red,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: MyListTile(
                    name: notifier.list[index].name!,
                    city: notifier.list[index].city!,
                    userList: notifier.list,
                    index: index,
                    id: notifier.list[index].id!,
                  ),
                );
              });

  }
}
