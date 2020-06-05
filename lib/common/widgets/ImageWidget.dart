import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {

  ImageWidget({@required this.url,this.width,this.height = 180,this.placeHolder = "images/place_holder.png"});

  ImageWidget.create(url):url = url,width = 0,height = 180,placeHolder = "images/place_holder.png";

  final String url;
  final double width,height;
  final String placeHolder;

  @override
  _ImageState createState() => _ImageState();

}

class  _ImageState extends State<ImageWidget> {

  Image _image;
  @override
  void initState() {
    super.initState();
    _image = Image.network(widget.url,width:300,height:200,fit: BoxFit.cover,);
    var resolve = _image.image.resolve(ImageConfiguration.empty);
    resolve.addListener(ImageStreamListener((_,__){

    },onError: (exception,stackTrace){
      setState(() {
        if(widget.width == 0 || widget.height == 0){
          _image = Image.network(widget.url,width:300,height:200,fit: BoxFit.cover,);
        } else {
          _image = Image.asset(
              widget.url,
              width: 300,
              height: 200,
              fit: BoxFit.cover
          );
        }
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      child: _image,
    );
  }

}