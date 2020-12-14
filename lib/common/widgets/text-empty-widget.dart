import 'package:flutter/material.dart';

//可以为空的Text
class TextEWidget extends StatelessWidget {

  const TextEWidget(this.data,{
  Key key,
  this.style,
  this.strutStyle,
  this.textAlign,
  this.textDirection,
  this.locale,
  this.softWrap,
  this.overflow,
  this.textScaleFactor,
  this.maxLines,
  this.semanticsLabel,
  this.textWidthBasis,
});

  final String data;

  final TextStyle style;

  final StrutStyle strutStyle;

  final TextAlign textAlign;

  final TextDirection textDirection;

  final Locale locale;

  final bool softWrap;

  final TextOverflow overflow;

  final double textScaleFactor;

  final int maxLines;

  final String semanticsLabel;

  final TextWidthBasis textWidthBasis;


  @override
  Widget build(BuildContext context) {
    return Text(data == null ? "" : data,style: style,strutStyle: strutStyle,textAlign: textAlign,textDirection: textDirection,locale: locale,
    softWrap: softWrap,overflow: overflow,textScaleFactor: textScaleFactor,maxLines: maxLines,semanticsLabel: semanticsLabel,textWidthBasis: textWidthBasis,);
  }

}