import 'package:flutter/material.dart';
import 'package:check_mazdor/models/Database.dart';
import 'package:check_mazdor/models/mazdor.dart';

class InsertTarikh extends StatefulWidget {
  final int id;
    final Function forHomeState;

  InsertTarikh({this.id, this.forHomeState});
  @override
  _InsertTarikhState createState() => _InsertTarikhState();
}

class _InsertTarikhState extends State<InsertTarikh> {
  final _tarikhController = TextEditingController();


  void _submit() async{
    final double tarikh = double.parse(_tarikhController.text.toString());
  await DBProvider.db.updateMyTarikh(tarikh, widget.id);
  widget.forHomeState();
  Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _tarikhController,
                decoration: InputDecoration(
                labelText:  "Tarikh"
              ),),
             RaisedButton(child: Text("Add"),onPressed:_submit,),
            ],
          ),
        ),
      ),
    );
  }
}