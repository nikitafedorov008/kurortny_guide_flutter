import 'package:flutter/material.dart';

class MapFilter extends StatefulWidget {
  @override
  _MapFilterState createState() => _MapFilterState();
}

class _MapFilterState extends State<MapFilter> {

  List<bool> _isChecked = [true, true, true, true, true, true];
  bool canUpload = true;

  List<String> _texts = [
    'Музеи',
    'Религия',
    'Военные обьекты',
    'Памятники',
    'Рестораны',
    'Отели и санатории',
  ];
  List<Icon> _icons = [
    Icon(Icons.museum),
    Icon(Icons.add_rounded),
    Icon(Icons.military_tech),
    Icon(Icons.account_box),
    Icon(Icons.food_bank),
    Icon(Icons.hotel),
  ];

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Text('Выберите категории'),
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //mainAxisSize: MainAxisSize.min,
            children: [
              ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8.0),
                  children: [
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _texts.length,
                      itemBuilder: (_, index) {
                        return CheckboxListTile(
                          title: Text(_texts[index]),
                          secondary: _icons[index],
                          value: _isChecked[index],
                          onChanged: (val) {
                            setState(() {
                              _isChecked[index] = val;
                              canUpload = true;
                              for (var item in _isChecked) {
                                if (item == false) {
                                  canUpload = false;
                                }
                              }
                            });
                          },
                        );
                      },
                    ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                      //onPressed:()=> onPressed
                    child: Text('Применить'),
                    onPressed: (){
                      Navigator.pop(context);
                      _isChecked[2] = false;
                    }
                    /*onPressed: canUpload ? () {
                      print('lol');
                    Navigator.pop(context);
                    } : null,*/
                  ),
                  MaterialButton(
                    //onPressed:()=> onPressed
                    child: Text('Отмена'),
                    onPressed: ()=> Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
      /*actions: <Widget>[
        SizedBox(
            width: 300,
            child: RaisedButton(
              color: Colors.blue,
              onPressed: canUpload
                  ? () {
                print("upload");
              }
                  : null,
              child: Text('Upload'),
            ))
      ],*/
    );
  }
}