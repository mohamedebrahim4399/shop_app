class LoginModel{

  bool? status;
  String? message;
  UserDataModel? data;
  LoginModel.formJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
    data=json['data'] !=null?UserDataModel.formJson(json['data']):null;
  }

}

class UserDataModel{

  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  UserDataModel.formJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];
  }
}