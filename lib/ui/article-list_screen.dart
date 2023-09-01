import 'package:counterapp/bloc/article_list_bloc.dart';
import 'package:counterapp/bloc/bloc_provider.dart';
import 'package:flutter/material.dart';

import '../data/article.dart';
import 'article_list_item.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ArticleListBLoc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Article"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Search'),
              onChanged: bloc.searchQuery.add,
            ),
          ),
          Expanded(child: _buildResults(bloc))
        ],
      ),
    );
  }

  Widget _buildResults(ArticleListBLoc bloc) {
    return StreamBuilder<List<Article>?>(
        stream: bloc.articleStream,
        builder: (context, snapshot) {
          final results = snapshot.data;
          if (results == null) {
            print(results?.length);
            return const Center(
              child: Text("Loading...."),
            );
          } else if (results.isEmpty) {
            return const Center(
              child: Text("No Results...."),
            );
          }
          return _buildSearchResults(results);
        });
  }
}

Widget _buildSearchResults(List<Article> results) {
  return  ListView.builder(
    itemCount: results.length,
    itemBuilder: (context, index) {
      final article = results[index];
      return InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // 1
          child: ArticleListItem(article: article),
        ),
        // 2
        onTap: () {
          // TODO: Later will be implemented
        },
      );
    },
  );
}
