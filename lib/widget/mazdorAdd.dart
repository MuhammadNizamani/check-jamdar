import 'package:check_mazdor/models/Database.dart';
import 'package:check_mazdor/models/mazdor.dart';
import 'package:flutter/material.dart';

class MazdorAdd extends StatefulWidget {
  final Function forHomeState;
  MazdorAdd({this.forHomeState});
  @override
  _MazdorAddState createState() => _MazdorAddState();
}

class _MazdorAddState extends State<MazdorAdd> {

  final _nameController = TextEditingController();
  final _phoneNOController = TextEditingController();
  void _submit()async {
    final String name1 = _nameController.text;
    final String phone = _phoneNOController.text;
    if(name1.isEmpty || phone.isEmpty){
      return;
    }
    await DBProvider.db.newMazdor(Mazdor(name:name1, phoneNO: phone ));
    widget.forHomeState();
    print(DBProvider.db.getAllMazdor().toString());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Card(
        elevation: 20,
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            children : <Widget>[

                TextField(
                  controller: _nameController,
                  decoration:  InputDecoration(
                    labelText:  "Name"
                  ),
                ),
                TextField(
                  controller:  _phoneNOController,
                  decoration:  InputDecoration(
                    labelText: "Phone No:"
                  ),
                ),
                RaisedButton(onPressed:_submit, child : Text("Add Mazdor"))



              
            ]
          ),
        ),
      ),
    );
  }
}
