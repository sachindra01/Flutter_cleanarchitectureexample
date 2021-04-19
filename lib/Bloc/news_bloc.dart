import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:cleanarchitecture_example/Model/newsmodel.dart';


enum NewsAction { fetch }

class NewBloc {
  Dio _dio;
  final String _endpoint =
      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=db80afe0209144429f877bdb48e30554";

  final _stateStreamController = StreamController<List<Article>>();
  StreamSink<List<Article>> get _newsSink => _stateStreamController.sink;

  Stream<List<Article>> get newsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<NewsAction>();
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get _eventstream => _eventStreamController.stream;

  NewBloc() {
    _eventstream.listen((event) async {
      if (event == NewsAction.fetch) {
        try {
          var news = await getNews();
         
          if(news != null) _newsSink.add(news.articles);
          else
           _newsSink.addError('something went wrong');
        } on Exception catch (e) {
          _newsSink.addError('something went wrong');
          // TODO
        }
      }
    });
    BaseOptions options =
        BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    _dio = Dio(options);
    _dio.interceptors.add;
  }
  Future<Newsheadline> getNews() async {
    Response response = await _dio.get(_endpoint);
    return Newsheadline.fromJson(response.data);
  }
}
