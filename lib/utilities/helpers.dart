//color
import 'package:flutter/material.dart';


const Color bgcolor = Color.fromARGB(255,255,255,255);
const Color greycircle = Color.fromARGB(255,244, 244, 244); // rgba(242, 242, 242, 1)
const Color textBlack = Color.fromARGB(255, 83, 96, 117);
const Color themeGreen = Color.fromARGB(255, 0, 200, 118);
const Color selectgrey = Color.fromARGB(255, 92, 92, 92);
const Color errorTheme = Color.fromRGBO(244, 67, 54, 1);
// ignore: constant_identifier_names
const Color rating_theme = Colors.amber;


class RatingStar extends StatefulWidget {
  const RatingStar({super.key});

  

  @override
  State<RatingStar> createState() => _RatingStarState();
}

class _RatingStarState extends State<RatingStar> {
  @override
  Widget build(BuildContext context) {
    int _rating = 3;

void rate(int rating) {
  
  setState(() {
    _rating = rating;
  });
}
    return Container(
      
    child:Center(
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           GestureDetector(
            child:  Icon(
              Icons.star,
              color: _rating >= 1 ? rating_theme : rating_theme.withOpacity(0.8),
            ),
            onTap: () => rate(1),
          ),
           GestureDetector(
            child:  Icon(
              Icons.star,
              color: _rating >= 2 ? rating_theme : rating_theme.withOpacity(0.7),
            ),
            onTap: () => rate(2),
          ),
           GestureDetector(
            child:  Icon(
              Icons.star,
              color: _rating >= 3 ? rating_theme : rating_theme.withOpacity(0.6),
            ),
            onTap: () => rate(3),
          ),
           GestureDetector(
            child:  Icon(
              Icons.star,
              color: _rating >= 4 ? rating_theme : rating_theme.withOpacity(0.5),
            ),
            onTap: () => rate(4),
          ),
           GestureDetector(
            child:  Icon(
              Icons.star,
              color: _rating >= 5 ? rating_theme : rating_theme.withOpacity(0.4),
            ),
            onTap: () => rate(5),
          )
        ],
      ),
    ) ,
    );
  }
}

