import 'dart:async';

import 'package:counterapp/bloc/bloc.dart';
import 'package:counterapp/data/rw_client.dart';
import 'package:rxdart/rxdart.dart';

import '../data/article.dart';

class ArticleDetailsBloc implements Bloc{
  final String id;
  final _refreshController = StreamController<void>();
  final _client = RWClient();

  late Stream<Article?> articleStream;

  ArticleDetailsBloc({required this.id}){
    articleStream = _refreshController.stream
        .startWith({})
        .mapTo(id)
        .switchMap((id) => _client.getDetailArticle(id).asStream()).asBroadcastStream();
  }
  Future refresh(){
    final future = articleStream.first;
    _refreshController.sink.add({});
    return future;
  }

  @override
  void dispose() {
_refreshController.close();
  }
}