import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:room_craft/api/api.dart';

import 'package:room_craft/helpers.dart';

import 'package:room_craft/model/model.dart';


class ItemViewPage extends StatefulWidget {
  var id;
  String pageTitle;
  ItemViewPage({
    super.key,
    required this.id,
    required this.pageTitle,
  });
  @override
  State<ItemViewPage> createState() => _ItemViewPageState();
}

class _ItemViewPageState extends State<ItemViewPage> {
  late Future<DataList> futureAlbum;

  Future<DataList> fetchAlbum() async {
    final response = await http.get(
        Uri.parse('https://api.escuelajs.co/api/v1/products/${widget.id}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return DataList.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    NotificationApi.init();
  }
  
 
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: greycircle,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(),
        title: const Text(
          'Living Room',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<DataList>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: height * 0.57,
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.55,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: 20, left: 20, top: 25),
                                height: height * 0.5,
                                child: Image.network(
                                  snapshot.data!.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: 2,
                          right: 20,
                          child: SizedBox(
                            height: width * 0.1,
                            child: Row(
                              children: [
                                FloatingActionButton(
                                  heroTag: null,
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.favorite,
                                    color: bgcolor,
                                  ),
                                ),
                                FloatingActionButton(
                                  heroTag: null,
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.close,
                                    color: bgcolor,
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child:Row(
                      children:const [
                        Text('Rating'),
                        RatingStar()
                       
                      ],
                    )
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SizedBox(
                            width: width * 0.6,
                            child: Text(
                              snapshot.data!.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: textBlack),
                            )),
                      )),
                  SizedBox(
                      width: width * 0.9,
                      child: Text(snapshot.data!.description,
                          maxLines: 3, overflow: TextOverflow.ellipsis)),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Text(
                          '\$${snapshot.data!.price}',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textBlack),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ElevatedButton(
                            onPressed: () {
               } ,  style: ElevatedButton.styleFrom(
                                backgroundColor: bgcolor),
                            child: const Text(
                              'Add to cart',
                              style: TextStyle(color: textBlack),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            NotificationApi.showNotification(
                                image: snapshot.data!.image,
                                title: snapshot.data!.title,
                                body:
                                    "\$${snapshot.data!.price} is added to cart...!",
                                payload: '');
                          },
                          child: const Text(
                            'Buy Now',
                            style: TextStyle(color: bgcolor),
                          ),
                        ),
                      ],
                    ),
                  ),
                
 ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
  
}
