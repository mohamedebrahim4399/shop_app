
class HomeModel{
  bool? status;
  HomeData? data;
  HomeModel.formJson(Map<String,dynamic> json){
    status =json['status'];
    data =HomeData.formJson(json['data']);
  }
}

class HomeData{
  List<Banners> banners=[];
  List<Products> products=[];
  HomeData.formJson(Map<String,dynamic> json){
    json['banners'].forEach((element){
      banners.add(Banners.formJson(element));
    });
    json['products'].forEach((element){
      products.add(Products.formJson(element));
    });
  }
}
class Banners{
  int? id;
  String? image;

  Banners.formJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}
class Products{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  Products.formJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}