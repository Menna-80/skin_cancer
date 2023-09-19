class ShopLoginModel {
   bool? status;
   String? message;
  UserModel? data;
  ShopLoginModel.fromjson(Map<String, dynamic> jsonData)
  {
     status = jsonData['status'];
    message = jsonData['message'];
    data = jsonData['data'] != null ? UserModel.fromjson(jsonData['data']):null;
  }
}

class UserModel {
   int? id;
  String? name;
   String? email;
   String? phone;
   String? image;
   String? token;

  UserModel.fromjson(Map<String, dynamic> jsonData){
    id = jsonData['id'];
    name = jsonData['name'];
    email = jsonData['email'];
    phone = jsonData['phone'];
    image = jsonData['image'];
    token = jsonData['token'];
  }
}
