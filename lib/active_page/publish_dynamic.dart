import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PublishDynamic extends StatefulWidget {
  @override
  DynamicState createState() => DynamicState();
}

class DynamicState extends State<PublishDynamic> {
  List<Asset> images = List<Asset>();

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {

    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      shrinkWrap: true,
      children: List.generate(images.length+1, (index) {
        if (index == images.length){
          return GestureDetector(
            child: Image.asset('images/add_img.png'),
            onTap: (){
              loadAssets();
            },
          );
        } else {
          print(images[index].name+"  "+images[index].identifier);
          Asset asset = images[index];
          return AssetThumb(
                  asset: asset,
                  width: 300,
                  height: 300,
              );
          }
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      );
    } on Exception catch (e) {
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(right: 16),
              child: Text('发表',style: TextStyle(fontSize: 14)),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: 120,
                  minHeight: 120
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 3, 16, 3),
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: '这一刻的想法',
                      border: InputBorder.none
                  ),
                ),),
            ),
          ),
          Divider(height: 1,color: Colors.grey[300]),
          buildGridView(),
        ],
      ),
    );
  }

}