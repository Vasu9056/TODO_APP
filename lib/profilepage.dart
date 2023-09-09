import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  final ImagePicker picker = ImagePicker();
  XFile? image;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: getimage(),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(context),
                  IconButton(
                      onPressed: () async {
                        image =
                            await picker.pickVideo(source: ImageSource.gallery);
                        setState(() {
                          image = image;
                        });
                      },
                      icon:
                          Icon(Icons.add_a_photo, color: Colors.teal, size: 30))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider getimage() {
    if (image != null) {
      return FileImage(File(image!.path));
    }
    return AssetImage('assets/vasu.JPG');
  }

  Widget button(context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width / 2,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Color(0xff8a32f1),
              Color(0xffad32f9),
            ])),
        child: Center(
          child: Text(
            'Upload',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
