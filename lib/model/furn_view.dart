import 'package:flutter/material.dart';
import 'package:room_craft/utilities/helpers.dart';
import 'package:room_craft/views/productDetailScreen.dart';

// ignore: must_be_immutable
class FurnView extends StatefulWidget {
  String image;
  String price;
  String title;
  String id;
  FurnView(
      {Key? key,
      required this.image,
      required this.title,
      required this.price,
      required this.id})
      : super(key: key);

  @override
  State<FurnView> createState() => _FurnViewState();
}

class _FurnViewState extends State<FurnView> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SizedBox(
            width: width * 0.5,
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.28,
                      child: Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.27,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3)),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Image.network(
                                    widget.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 20,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.09,
                          child: FittedBox(
                            child: FloatingActionButton(
                              heroTag: null,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ItemViewPage(
                                          id: widget.id,
                                          pageTitle: '',
                                        )));
                              },
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: width * 0.33,
                        child: Text(
                          widget.title,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(color: textBlack),
                        ),
                      ),
                      // Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8, left: 4),
                        child: Text('\$${widget.price}',
                            style: const TextStyle(
                                color: textBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
