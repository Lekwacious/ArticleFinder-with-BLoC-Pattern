import 'dart:async';

import 'package:counterapp/bloc/bloc.dart';
import 'package:counterapp/data/article.dart';
import 'package:counterapp/data/rw_client.dart';
import 'package:rxdart/rxdart.dart';
class ArticleListBLoc implements Bloc{
  final _client = RWClient();

  final _searchQueryController = StreamController<String?>();
  Sink<String?> get searchQuery => _searchQueryController.sink;
   late Stream<List<Article>?> articleStream;


  ArticleListBLoc(){
    articleStream = _searchQueryController.stream.startWith(null)
    .debounceTime(const Duration(microseconds: 100))
    .switchMap((query) => _client.fetchArticles(query)
        .asStream()
        .startWith(null),
    );
  }

  @override
  void dispose() {
    _searchQueryController.close();
  }



}