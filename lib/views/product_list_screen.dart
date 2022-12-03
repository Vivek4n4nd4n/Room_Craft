import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:room_craft/model/furn_view.dart';
import 'package:room_craft/utilities/helpers.dart';
import 'package:room_craft/views/productDetailScreen.dart';
import 'package:room_craft/model/model.dart';
import 'package:http/http.dart' as http;

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  Future<List<DataList>> fetchAlbum() async {
    final response =
        await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products'));
    // await http.get(Uri.parse('https://api.unsplash.com/photos/?client_id=3vVBhd4My8TFGBJZBHjxvNxAebjIeYaORKb16kwQZNw'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => DataList.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.10,
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Discover',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: textBlack),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 30,
                  ),
                ),
              ],
            ),
            Expanded(child: _navigationButtons()),
            Expanded(flex: 10, child: _stackedContainers()),
          ],
        ),
      ),
    );
  }

  Widget _stackedContainers() {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.3;
    final double itemWidth = size.width / 2;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: IndexedStack(
        index: index,
        children: <Widget>[
          FutureBuilder<List<DataList>>(
              future: fetchAlbum(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MasonryGridView.builder(
                    scrollDirection: Axis.vertical,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 2,
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print(snapshot.data![index].id.toString());
                          print(1);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ItemViewPage(
                                    id: snapshot.data![index].id,
                                    pageTitle: "",
                                  )));
                        },
                        child: FurnView(
                            image: snapshot.data![index].image.toString(),
                            title: snapshot.data![index].title.toString(),
                            id: snapshot.data![index].id.toString(),
                            price: snapshot.data![index].price.toString()),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              }),
          const Center(child: Text('Kitchan & Dining')),
          const Center(child: Text('Home Office')),
          const Center(child: Text('Bed Room')),
        ],
      ),
    );
  }

  Widget _navigationButtons() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: index == 0 ? selectgrey : greycircle),
              child: Text(
                'Living Room',
                style: TextStyle(
                    fontSize: 16.0, color: index == 0 ? bgcolor : textBlack),
              ),
              onPressed: () {
                setState(() {
                  index = 0;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: index == 1 ? selectgrey : greycircle),
              child: Text(
                'Kitchan & Dining',
                style: TextStyle(
                    fontSize: 16.0, color: index == 1 ? bgcolor : textBlack),
              ),
              onPressed: () {
                setState(() {
                  index = 1;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: index == 2 ? selectgrey : greycircle),
              child: Text(
                'Home Office',
                style: TextStyle(
                    fontSize: 16.0, color: index == 2 ? bgcolor : textBlack),
              ),
              onPressed: () {
                setState(() {
                  index = 2;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: index == 3 ? selectgrey : greycircle),
              child: Text(
                'bed Room',
                style: TextStyle(
                    fontSize: 16.0, color: index == 3 ? bgcolor : textBlack),
              ),
              onPressed: () {
                setState(() {
                  index = 3;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
