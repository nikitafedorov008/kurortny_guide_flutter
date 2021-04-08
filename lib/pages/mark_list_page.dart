import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kurortny_guide_flutter/model/mark.dart';
import 'package:kurortny_guide_flutter/pages/mark_detail.dart';
import 'package:kurortny_guide_flutter/pages/place_page.dart';
import 'package:kurortny_guide_flutter/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class MarkListPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MarkListPageState();
  }
}

class MarkListPageState extends State<MarkListPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Mark> markList;
  int count = 0;
  int page;

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  void _delete(BuildContext context, Mark mark) async {
    int result = await databaseHelper.deleteTodo(mark.id);
    if (result != 0) {
      _showSnackBar(context, 'Закладка успешно удалена');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Mark mark, String title) async {
    bool result =
    /*await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TodoDetail(todo, title);
    }));*/
    await showDialog(
        context: context,
        builder: (BuildContext buildContext){
          return Container(
              width: 300,
              height: 300,
              child: MarkDetail(mark, title));
        }
    );
    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Mark>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((markList) {
        setState(() {
          this.markList = markList;
          this.count = markList.length;
        });
      });
    });
  }

  ListView getTodoListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              foregroundColor: Colors.black45,
              backgroundColor: Colors.cyan,
              child: Text(getFirstLetter(this.markList[position].title),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.markList[position].title,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('страница: №' + this.markList[position].description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                    onPressed:(){
                      debugPrint("ListTile Tapped");
                      navigateToDetail(this.markList[position], 'Изменить Закладку');
                    },
                    icon: Icon(Icons.edit, color: Colors.blue,),
                ),
                GestureDetector(
                  child: Icon(Icons.delete,color: Colors.red,),
                  onTap: () {
                    _delete(context, markList[position]);
                  },
                ),
              ],
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              //navigateToDetail(this.markList[position], 'Изменить Закладку');
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (_) => PlacePage(page: page = int.tryParse(this.markList[position].description),),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (markList == null) {
      markList = List<Mark>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Закладки'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: getTodoListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB нажата');
          navigateToDetail(Mark('', '', ''), 'Добавить закладку');
        },
        tooltip: 'Добавить Закладку',
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: HexColor('#A23457'),
      ),
    );
  }

}