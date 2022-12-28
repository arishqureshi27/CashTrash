import 'package:firebase_auth101/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:custom_text/custom_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {



  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        //leading: SizedBox(),
        centerTitle: true,
        title: Text('Profile'),
        actions: <Widget>[
          TextButton(
              onPressed: () {},
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),)
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 290,
            child: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: 190,
                    color: Colors.green,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        height: 148,
                        width: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 8,

                          ),
                          image:  DecorationImage(
                            fit: BoxFit.cover,
                              image: AssetImage('bg1.png'),
                          ),
                        ),
                      ),
                      Text('Ayan Sharma',style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,

                      ),),
                      SizedBox(height: 5,),
                      Text('ayansharma.davv@gmail.com',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.green,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
    throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw UnimplementedError();
  }
}
