import 'dart:convert';

Mazdor mazdorFromJson(String str){
  final jsonData = json.decode(str);
  return Mazdor.fromMap(jsonData);
}

String mazdorToJson(Mazdor data){
  final dyn =  data.toMap();

  return json.encode(dyn);
}

class Mazdor {
  int id;
  String name;
  String phoneNO;
  double tarikh;
  int numberOfTarikh;

  Mazdor({this.id, this.name, this.phoneNO, this.numberOfTarikh, this.tarikh});

  factory Mazdor.fromMap(Map<String, dynamic> json) => new Mazdor(id: json["id"],
  name: json["name"],
  phoneNO:json["phoneNO"],
  tarikh: json["tarilk"],
  numberOfTarikh: json["numberOfTarikh"],
  );

  Map<String, dynamic> toMap() =>{
    "id":id,
    "name":name,
    "phoneNO": phoneNO,
    "tarikh":tarikh,
    "numberOfTarikh": numberOfTarikh,

  };
}
