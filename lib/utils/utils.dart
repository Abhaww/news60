import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news360_api/models/category_list_model/category.dart';
import 'package:news360_api/models/news_data_model/news_data.dart';
import 'package:news360_api/models/tags_list_model/tags.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class Utils extends ChangeNotifier {
 static void showToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.teal,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
 static void shareImage (Uint8List uInt8List) async {
    // RenderRepaintBoundary renderRepaintBoundary =
    // containerKey.currentContext.findRenderObject();
    // ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 3);
    // ByteData? byteData = await boxImage.toByteData(format: ui.ImageByteFormat.png);
    // Uint8List uInt8List = byteData!.buffer.asUint8List();
    final directory = await getApplicationDocumentsDirectory();
    File imageFile = File('${directory.path}/news60.png');
    imageFile.writeAsBytesSync(uInt8List);
    try {
      await Share.shareFiles(
          [imageFile.path],
          text:
          'Download News60 app from Playstore and Appstore');
    } catch (e) {
      print('error: $e');
    }
  }

  static void saveImage (Uint8List uInt8List) async {
    // RenderRepaintBoundary renderRepaintBoundary =
    // containerKey.currentContext.findRenderObject();
    // ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 3);
    // ByteData? byteData = await boxImage.toByteData(format: ui.ImageByteFormat.png);
    // Uint8List uInt8List = byteData!.buffer.asUint8List();
    try {
      await [Permission.storage].request();
      final time = DateTime.now()
          .toIso8601String()
          .replaceAll('.', '_')
          .replaceAll(':', "_");
      final name = 'news360_screenshot_$time';
      final result = await ImageGallerySaver.saveImage(uInt8List, name: name);
      showToast('Saved!');
      return result['filePath'];
    } catch (e) {
      print('error: $e');
    }
  }
 static Future cacheImage (BuildContext context, String urlImage) async {
   await precacheImage(CachedNetworkImageProvider(urlImage), context);
 }
  late List<NewsData> newsLoaded;
  late List<Tags> tagList;
  late List<Category> categoryCard;
  bool bookmarked = false;
 int currentIndex = 0;
  bool showHideWatermark = false;
  void bookmark (bool bookmark){
    bookmarked = bookmark;
    notifyListeners();
  }
  void showWatermark (){
    showHideWatermark = true;
    notifyListeners();
  }
 void hideWatermark (){
   showHideWatermark = false;
   notifyListeners();
 }
  void assignData (List<NewsData> news){
    newsLoaded = news;
    notifyListeners();
  }
  void getTagList (List<Tags> taggs){
    tagList = taggs;
    notifyListeners();
  }
  void getCategoryList (List<Category> categories){
    categoryCard = categories;
    notifyListeners();
  }

  void getCurrentIndex (int newIndex){
    currentIndex = newIndex;
    notifyListeners();
  }

  String getUrl (){
    return newsLoaded[currentIndex].newsLink;
  }
}