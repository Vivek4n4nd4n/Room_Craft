
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DataList {
 final String image;
 final String price;
 final String description;
 final String title;
 final int id;
  DataList({required this.image,required this.price,required this.description,required this.title,required this.id});

 factory DataList.fromJson(Map<String, dynamic> json) {
    return DataList(
    image : json["category"]["image"],
    title : json['title'],
    id : json['id'],
    price : json['price'].toString(),
    description : json['description'],
    );
  }


  
}
