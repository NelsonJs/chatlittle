import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PublishDynamic extends StatefulWidget {
  @override
  DynamicState createState() => DynamicState();
}

class DynamicState extends State<PublishDynamic> {
  List<Asset> images = List<Asset>();
  int gridCount = 0;
  bool showLoading = false;
  TextEditingController editingController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    setState(() {
      gridCount = images.length+1;
    });
    super.initState();
  }

  Widget buildGridView() {

    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      shrinkWrap: true,
      children: List.generate(gridCount, (index) {
        if (index == images.length){
          return Offstage(
            offstage: images.length < 9 ? false : true,
            child: GestureDetector(
              child: Image.asset('images/add_img.png',scale: 1.5),
              onTap: (){
                loadAssets();
              },
            ),
          );
        } else {
          print(images[index].name+"  "+images[index].identifier);
          Asset asset = images[index];
          return Container(

            child: AssetThumb(
              asset: asset,
              width: 50,
              height: 50,
            ),
          );
          }
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 9,
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
      if (images.length < 9) {
        gridCount = images.length+1;
      } else {
        gridCount = images.length;
      }
    });
  }

  commit() async {
    List<List<int>> byts = [];
    for (var i = 0; i < images.length; i++) {
      var byteData = await images[i].getByteData();
      byts.add(byteData.buffer.asUint8List());
    }
    Net().dynamicImage(byts).then((value){
        if (value.code == 1){
          Net().publishDynamic(value.data,titleController.text.toString(), editingController.text.toString()).then((value) {
            if (value.code > 0) {
              Navigator.pop(context);
            }
          });
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        actions: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(right: 16),
              child: GestureDetector(
                child: Text('发表',style: TextStyle(fontSize: 14)),
                onTap: (){
                  setState(() {
                    showLoading = true;
                  });
                  commit();
                },
              ),
            ),
          )
        ],
      ),
      body: showLoading ? Center(child: CupertinoActivityIndicator(radius: 15)) : Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(16, 3, 16, 3),
                child: TextField(
                  controller: titleController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: '标题',
                      border: InputBorder.none
                  ),
                )),
            Divider(height: 1,color: Colors.grey[300]),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: 120,
                    minHeight: 120
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 3, 16, 3),
                  child: TextField(
                    controller: editingController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        hintText: '这一刻的想法',
                        border: InputBorder.none
                    ),
                  )),
              ),
            ),
            Divider(height: 1,color: Colors.grey[300]),
            Container(
              child: buildGridView(),
            ),
          ],
        ),
      )
    );
  }

}