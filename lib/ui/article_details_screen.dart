
import 'package:counterapp/bloc/article_details_bloc.dart';
import 'package:counterapp/bloc/bloc_provider.dart';
import 'package:counterapp/data/article.dart';
import 'package:flutter/material.dart';

import 'article_detail.dart';

class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ArticleDetailsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Article details"),
      ),
      body: RefreshIndicator(
        onRefresh: bloc.refresh,
        child: Container(
          alignment: Alignment.center,
          child: _buildContent(bloc),
        ),
      ),
    );
  }
  Widget _buildContent(ArticleDetailsBloc bloc){
    return StreamBuilder<Article?>(
      stream: bloc.articleStream,
        builder: (context, snapshot){
        final article = snapshot.data;
        if(article == null){
          return const Center(child: CircularProgressIndicator(),);
        }
        return ArticleDetail(article);
        }
    );
  }
}
