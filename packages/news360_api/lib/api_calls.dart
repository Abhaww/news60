import 'dart:async';
import 'dart:convert';
import 'package:news360_api/models/bookmark_model/bookmark_model.dart';
import 'news360_api.dart';
import 'package:http/http.dart' as Http;

const String url = 'https://news60.it/api/modules/appModules/operations/app_operations.php';

class ApiCalls {
  DeviceIdModel? _deviceIdModel;
  late CategoryList _categoryList;
  late NewsDataBySearchModel _bySearchModel;
  late NewsDataModel _newsDataModel;
  late TagListModel _tagListModel;
  Future<DeviceIdResponse?> deviceId(String? deviceId) async {
    Http.Response? _response;
    DeviceIdResponse? deviceIdResponse;
    try {
      _response = await Http.post(Uri.parse(url),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      },
        body: <String, String>{
          'action': 'checkingdeviceid',
          'device_id': deviceId!,
        },
      );
      if (_response.statusCode == 200) {
        var decodedResponses = jsonDecode(_response.body);
        var statusCode = decodedResponses['statusCode'];
        print(statusCode);
        if (statusCode == 1 || statusCode == '1') {
          _deviceIdModel = DeviceIdModel.fromJson(decodedResponses);
          print(_deviceIdModel);
          deviceIdResponse = _deviceIdModel!.response;
          print(deviceIdResponse);
        } else {
          deviceIdResponse = null;
        }
      } else {
        print('An error occurred');
      }
    } on Exception catch (e) {
      print(e);
    }
    return deviceIdResponse;
  }

  Future<List<Category>> getCategories(String? deviceId) async {
    Http.Response _response;
    late List<Category> categories;
    try {
      _response = await Http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: <String, String>{
          'action': 'getcategoriesdata',
          'device_id': deviceId!,
        },
      );
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        int statusCode = decodedResponse['statusCode'];
        if (statusCode == 1) {
          _categoryList = CategoryList.fromJson(decodedResponse);
          categories = _categoryList.response;
        } else {
          categories = [];
        }
      } else {
        print('An error occurred');
      }
    } on Exception catch (e) {
      print(e);
    }
    return categories;
  }

  Future<List<NewsData>> getDataBySearch(String? deviceId, searchKey) async {
    Http.Response _response;
    late List<NewsData> newsData;
    try {
      _response = await Http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: <String, String>{
          'action': 'getnewsdatabysearch',
          'search_key': searchKey,
          'device_id': deviceId!,
        },
      );
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        int statusCode = decodedResponse['statusCode'];
        if (statusCode == 1) {
          _bySearchModel = NewsDataBySearchModel.fromJson(decodedResponse);
          newsData = _bySearchModel.response;
        } else {
          newsData = [];
        }
      } else {
        print('An error occurred');
      }
    } on Exception catch (e) {
      print(e);
    }
    return newsData;
  }

  Future<List<NewsData>> getDataByTag(String? deviceId, tagId) async {
    Http.Response _response;
    late List<NewsData> newsData;
    try {
      _response = await Http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: <String, String>{
          'action': 'getnewsbytagid',
          'tag_id': tagId,
          'device_id': deviceId!,
        },
      );
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        int statusCode = decodedResponse['statusCode'];
        if (statusCode == 1) {
          _bySearchModel = NewsDataBySearchModel.fromJson(decodedResponse);
          newsData = _bySearchModel.response;
        } else {
          newsData = [];
        }
      } else {
        print('An error occurred');
      }
    } on Exception catch (e) {
      print(e);
    }
    return newsData;
  }
  Future<List<NewsData>> getDataByCategory (String? deviceId,String catId) async {
    Http.Response _response;
    late List<NewsData> newsData;
    try {
      _response = await Http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: <String, dynamic>{
          'action': 'getnewsbycategoryid',
          'cat_id': catId,
          'device_id': deviceId!,
        },
      );
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        int statusCode = decodedResponse['statusCode'];
        if (statusCode == 1) {
          _newsDataModel = NewsDataModel.fromJson(decodedResponse);
          newsData = _newsDataModel.response;
        } else {
          throw Exception('failed to fetch news');
        }
      } else {
        print('An error occurred');
      }
    } on Exception catch (e) {
      print(e);
    }
    return newsData;
  }
  Future<List<NewsData>> getNewsData(String? deviceId) async {
    Http.Response _response;
    late List<NewsData> newsData;
    try {
      _response = await Http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: <String, String>{
          'action': 'getnewsdata',
          'device_id': deviceId!,
        },
      );
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        int statusCode = decodedResponse['statusCode'];
        if (statusCode == 1) {
          _newsDataModel = NewsDataModel.fromJson(decodedResponse);
          newsData = _newsDataModel.response;
        } else {
          newsData = [];
        }
      } else {
        print('An error occurred');
      }
    } on Exception catch (e) {
      print(e);
    }
    return newsData;
  }

  Future<List<Tags>> getTagList(String? deviceId) async {
    Http.Response _response;
    late List<Tags> tags;
    try {
      _response = await Http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: <String, String>{
          'action': 'gettagsdata',
          'device_id': deviceId!,
        },
      );
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        int statusCode  = decodedResponse['statusCode'];
        if (statusCode == 1) {
          _tagListModel = TagListModel.fromJson(decodedResponse);
          tags = _tagListModel.response;
        } else {
          tags = [];
        }
      } else {
        print('An error occurred');
      }
    } on Exception catch (e) {
      print(e);
    }
    return tags;
  }

  Future<Bookmark> saveBookmark (String? deviceId, userId, newsId)async{
    Http.Response _response;
    late Bookmark bookmark;
    try{
      _response = await Http.post(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: {
            'action': 'savebookmark',
            'device_id': deviceId!,
            'user_id': userId!,
            'news_id': newsId,
          }
      );
      if (_response.statusCode == 200){
        var decodedResponse = jsonDecode(_response.body);
        bookmark = Bookmark.fromJson(decodedResponse);
      }else {
        print('An error occurred');
      }
    } on Exception catch (e) {
      print(e);
    }
    return bookmark;
  }

  Future<List<NewsData>> getBookmarkData (String deviceId, userId)async{
    Http.Response _response;
    late List<NewsData> newsData;
    try {
      _response = await Http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: <String, dynamic>{
          'action': 'getbookmarkbydeviceid',
          'user_id': userId,
          'device_id': deviceId,
        },
      );
      if (_response.statusCode == 200) {
        var decodedResponse = jsonDecode(_response.body);
        int statusCode = decodedResponse['statusCode'];
        if (statusCode == 1) {
          _newsDataModel = NewsDataModel.fromJson(decodedResponse);
          newsData = _newsDataModel.response;
        } else {
          throw Exception('failed to fetch news');
        }
      } else {
        print('An error occurred');
      }
    } on Exception catch (e) {
      print(e);
    }
    return newsData;
  }
  Future<Bookmark> removeBookmark (String deviceId, userId, newsId)async{
    Http.Response _response;
    late Bookmark bookmark;
    try{
      _response = await Http.post(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: {
            'action': 'removebookmarkbydeviceid',
            'device_id': deviceId,
            'user_id': userId,
            'news_id': newsId,
          }
      );
      if (_response.statusCode == 200){
        var decodedResponse = jsonDecode(_response.body);
        bookmark = Bookmark.fromJson(decodedResponse);
      }else {
        print('An error occurred');
      }
    } on Exception catch (e) {
      print(e);
    }
    return bookmark;
  }
}
