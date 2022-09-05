class User {
  int? id;
  String? name;
  String? city;
  User({this.id,this.name, this.city});

  Map<String,dynamic>toMap(){
    return {'id':id,'name':name, 'city': city};
  }
}
