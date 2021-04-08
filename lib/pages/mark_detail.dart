import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kurortny_guide_flutter/model/mark.dart';
import 'package:kurortny_guide_flutter/utils/database_helper.dart';

class MarkDetail extends StatefulWidget {

	final String appBarTitle;
	final Mark mark;

	MarkDetail(this.mark, this.appBarTitle);

	@override
	State<StatefulWidget> createState() {
		return MarkDetailState(this.mark, this.appBarTitle);
	}
}

class MarkDetailState extends State<MarkDetail> {

	DatabaseHelper helper = DatabaseHelper();

	String appBarTitle;
	Mark mark;

	TextEditingController titleController = TextEditingController();
	TextEditingController descriptionController = TextEditingController();

	MarkDetailState(this.mark, this.appBarTitle);

	@override
	Widget build(BuildContext context) {

		TextStyle textStyle = Theme.of(context).textTheme.title;

		titleController.text = mark.title;
		descriptionController.text = mark.description;

		return SimpleDialog(
			shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(16.0)
			),
			title: Text('Закладка'),
			children: [
				SimpleDialogOption(
					child: TextField(
						controller: titleController,
						style: textStyle,
						onChanged: (value) {
							debugPrint('Something changed in Title Text Field');
							updateTitle();
						},
						decoration: InputDecoration(
								labelText: 'Назвние (обязательно)',
								labelStyle: textStyle,
								border: OutlineInputBorder(
										borderRadius: BorderRadius.circular(24.0)
								)
						),
					),
				),
				SimpleDialogOption(
					child: TextField(
						controller: descriptionController,
						style: textStyle,
						onChanged: (value) {
							debugPrint('Something changed in Description Text Field');
							updateDescription();
						},
						keyboardType: TextInputType.number,
						decoration: InputDecoration(
								labelText: 'Страница',
								labelStyle: textStyle,
								border: OutlineInputBorder(
										borderRadius: BorderRadius.circular(24.0)
								)
						),
					),
				),
				SimpleDialogOption(
					child: Row(
						mainAxisAlignment: MainAxisAlignment.spaceEvenly,
						children: <Widget>[
							Expanded(
								child: OutlineButton(
									//color: Theme.of(context).primaryColorDark,
									//textColor: Theme.of(context).primaryColorLight,
									shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
									child: Row(
										children: [
											Icon(Icons.add_circle_outline, color: Colors.green,),
											SizedBox(width: 2,),
											Text(
												'Сохранить',
												style: TextStyle(color: Colors.green, fontSize: 10.8),
												textScaleFactor: 1.5,
											),
										],
									),
									onPressed: () {
										setState(() {
											debugPrint("Save button clicked");
											_save();
										});
									},
								),
							),

							Container(width: 5.0,),

							Expanded(
								child: OutlineButton(
									//color: Theme.of(context).primaryColorDark,
									//textColor: Theme.of(context).primaryColorLight,
									shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
									child: Row(
										mainAxisAlignment: MainAxisAlignment.center,
										children: [
											Icon(Icons.cancel_outlined, color: Colors.red,),
											SizedBox(width: 2,),
											Text(
												'Удалить',
												style: TextStyle(color: Colors.red, fontSize: 10.8),
												textScaleFactor: 1.5,
											),
										],
									),
									onPressed: () {
										setState(() {
											debugPrint("Delete button clicked");
											_delete();
										});
									},
								),
							),

						],
					),
				),
			],
		);
	}

	void moveToLastScreen() {
		Navigator.pop(context, true);
	}

	// Update the title of todo object
	void updateTitle(){
		mark.title = titleController.text;
	}

	// Update the description of todo object
	void updateDescription() {
		mark.description = descriptionController.text;
	}

	// Save data to database
	void _save() async {

		moveToLastScreen();

		mark.date = DateFormat.yMMMd().format(DateTime.now());
		int result;
		if (mark.id != null) {  // Case 1: Update operation
			result = await helper.updateTodo(mark);
		} else { // Case 2: Insert Operation
			result = await helper.insertTodo(mark);
		}

		if (result != 0) {  // Success
			_showAlertDialog('Статус', 'Закладка успешно сохранена');
		} else {  // Failure
			_showAlertDialog('Статус', 'Возникла проблема во время удаления закладки');
		}

	}


	void _delete() async {

		moveToLastScreen();

		if (mark.id == null) {
			_showAlertDialog('Статус', 'Ни одной закладки не удалено');
			return;
		}

		int result = await helper.deleteTodo(mark.id);
		if (result != 0) {
			_showAlertDialog('Статус', 'Закладка была успешно удалена');
		} else {
			_showAlertDialog('Статус', 'Возникла ошибка при удалении закладки');
		}
	}

	void _showAlertDialog(String title, String message) {

		AlertDialog alertDialog = AlertDialog(
			title: Text(title),
			content: Text(message),
		);
		showDialog(
				context: context,
				builder: (_) => alertDialog
		);
	}

}