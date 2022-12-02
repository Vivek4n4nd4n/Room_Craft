//color
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color bgcolor = Color.fromARGB(255,255,255,255);
const Color greycircle = Color.fromARGB(255,244, 244, 244); // rgba(242, 242, 242, 1)
const Color textBlack = Color.fromARGB(255, 83, 96, 117);
const Color themeGreen = Color.fromARGB(255, 0, 200, 118);
const Color selectgrey = Color.fromARGB(255, 92, 92, 92);
const Color errorTheme = Color.fromRGBO(244, 67, 54, 1);
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



// // // import 'dart:io';

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter/services.dart';

// // // import 'package:image_picker/image_picker.dart';


// import 'package:shared_preferences/shared_preferences.dart';

// class UserSimpleprefrences {
//   static SharedPreferences? _preferences;
//   static const _keyUsername = 'usarname';

//   static const _keyPassword = 'password';
//   static Future init() async =>
//       _preferences = await SharedPreferences.getInstance();

//   static Future setUsername(String name) async =>
//       await _preferences!.setString(_keyUsername, name);
//   static String? getUserName() => _preferences!.getString(_keyUsername);

//   static Future setPassword(String password) async =>
//       await _preferences!.setString(_keyPassword, password);
//   static String? getPassword() => _preferences!.getString(_keyPassword);
// }


// // // class SharedPreferenceImage extends StatefulWidget {
// // //   const SharedPreferenceImage({Key? key}) : super(key: key);

// // //   @override
// // //   State<SharedPreferenceImage> createState() => _SharedPreferenceImageState();
// // // }

// // // class _SharedPreferenceImageState extends State<SharedPreferenceImage> {
// // //   Future<File>? imageFile;
// // //   Future pickImageFromGallery(ImageSource source) async {
// // //     imageFile = (await ImagePicker().pickImage(source: source)) as Future<File>;
// // //   }

// // //   Widget imagefromGallery() {
// // //     return FutureBuilder<File>(
// // //         future: imageFile,
// // //         builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
// // //           if (snapshot.connectionState == ConnectionState.done) {
// // //             if (null == snapshot.data) {
// // //               return Text('error');
// // //             }
// // //             return Image.file(snapshot.data);
// // //           }
// // //         });
// // //   }

// // //   /*Future pickImageFromGallery(ImageSource source) async {
// // //     try {
// // //       final image = await ImagePicker().pickImage(source: source);
// // //       if (image == null) return;

// // //       final temporaryImage = File(image.path);
// // //       setState(() {
// // //         this.image = temporaryImage;
// // //       });
// // //     } on PlatformException catch (e) {
// // //       print("Unable to Pick image $e");
// // //     }
// // //   }
// // // */
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Image From gallery'),
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           imageFile != null
// // //               ? Image.file(
// // //                   image,
// // //                   width: 180,
// // //                   height: 180,
// // //                   fit: BoxFit.cover,
// // //                 )
// // //               : FlutterLogo(
// // //                   size: 200,
// // //                 ),
// // //           Padding(
// // //             padding: const EdgeInsets.all(8.0),
// // //             child: ElevatedButton(
// // //                 onPressed: () {
// // //                   pickImage(ImageSource.gallery);
// // //                 },
// // //                 child: Text('imagefrom gallery')),
// // //           ),
// // //           GestureDetector(
// // //               onTap: () {},
// // //               child: Container(
// // //                 height: MediaQuery.of(context).size.height / 5,
// // //                 width: MediaQuery.of(context).size.width / 2,

// // //                 //  child: Image(image: AssetImage('assets/child.webp')),
// // //               )),
// // //           ElevatedButton(
// // //               onPressed: () {
// // //                 pickImage(ImageSource.camera);
// // //               },
// // //               child: Text('Image from camera'))
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }




