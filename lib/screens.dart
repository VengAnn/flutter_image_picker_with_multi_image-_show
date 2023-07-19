import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker picker = ImagePicker();
  List<File> lsImgPreview = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Multiple Screens'),
      ),
      //
      body: Column(
        children: [
          lsImgPreview.isNotEmpty
              ? Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return Image.file(
                        lsImgPreview[index],
                        fit: BoxFit.cover,
                        //
                      );
                    },
                    //
                    itemCount: lsImgPreview.length,
                  ),
                )
              : Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: Text("No Image Selected")),
                  ),
                ),
        ],
      ),
      //
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<XFile>? lsImages = await picker.pickMultiImage();
          if (lsImgPreview.length >= 5) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You can select only 5 item'),
              ),
            );
            return;
          }
          //
          if (lsImages.length > 0) {
            for (int i = 0; i < lsImages.length; i++) {
              if (lsImgPreview.length < 5) {
                lsImgPreview.add(
                  File(lsImages[i].path),
                );
              }
            }
          }
          setState(() {});
        },
        child: const Icon(Icons.upload),
      ),
    );
  }
}
