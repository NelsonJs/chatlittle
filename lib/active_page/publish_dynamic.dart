import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:littelchat/common/util/Net.dart';
import 'package:littelchat/common/util/hex-color.dart';
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
          Asset asset = images[index];
          return ClipRRect(
            child: AssetThumb(asset: asset, width: 300, height: 300),
            borderRadius:  BorderRadius.all(Radius.circular(3)),
          );
          }
      }),
    );
  }
  List<Asset> resultList = List<Asset>();
  Future<void> loadAssets() async {


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
          Net().publishDynamic(value.data,titleController.text.toString()).then((value) {
            if (value.code > 0) {
              Navigator.pop(context,true);
            } else {
              if (value.msg.isNotEmpty){
                  Fluttertoast.showToast(msg: value.msg);
              }
              setState(() {
                canClick = true;
              });
            }
          });
        } else {
         setState(() {
           canClick = true;
         });
        }
    });
  }

  bool canClick = true;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Padding(
            child: Icon(Icons.arrow_back_ios,size: 18,),
            padding: EdgeInsets.only(top: 7),
          ),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        elevation: 0.5,
        actions: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(right: 16),
              child: SizedBox(
                child: RaisedButton(
                  child: Text('发表',style: TextStyle(fontSize: 14)),
                  color: HexColor("3299cc"),
                  textColor: Colors.white,
                  disabledColor: Colors.grey[300],
                  onPressed: canClick ? (){
                    setState(() {
                      showLoading = true;
                      canClick = false;
                    });
                    commit();
                  } : null,
                ),
                width: 65,
                height: 32,
              )
            ),
          )
        ],
      ),
      body: showLoading ? Center(child: CupertinoActivityIndicator(radius: 15)) : SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
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
                        controller: titleController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            hintText: '这一刻的想法...',
                            hintStyle: TextStyle(fontSize: 14,color: HexColor("3e3e3e")),
                            border: InputBorder.none
                        ),
                      )),
                ),
              ),
              Divider(height: 1,color: Colors.grey[300]),
              Container(
                margin: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
                child: buildGridView(),
              ),
            ],
          ),
        ),
      )
    );
  }

}