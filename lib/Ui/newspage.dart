import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../Bloc/news_bloc.dart';
import '../Model/newsmodel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newsBloc = NewBloc();

  @override
  void initState() {
    newsBloc.eventSink.add(NewsAction.fetch);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0Xff1c1c1c),
      appBar: AppBar(
        backgroundColor: Color(0Xff1c1c1c),
        title: Center(
            child: Text(
          'Tech Headlines',
          style: TextStyle(color: Color(0xffFF8F0E)),
        )),
      ),
      body: Container(
        child: StreamBuilder<List<Article>>(
          stream: newsBloc.newsStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Center(
              child: Text(snapshot.error??'Error'),
            );
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final article = snapshot.data[index];
                    var formattedTime = DateFormat('dd MMM - HH:mm')
                        .format(article.publishedAt);
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => NewsDetail(
                        //               title: article.title,
                        //               urlToImage: article.urlToImage,
                        //               description: article.description,
                        //               url: article.url,
                        //               author: article.author,
                        //               publishedAt: article.publishedAt,
                        //             )));
                      },
                      child: Container(
                        height: 100,
                        margin: const EdgeInsets.all(8),
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context)=>NewsDetail(
                                //      title: article.title,
                                //       urlToImage: article.urlToImage,
                                //       description: article.description,
                                //       url: article.url,
                                //       author: article.author,
                                //       publishedAt: article.publishedAt,
                                //
                                //
                                //
                                //     )
                                //     ));
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Image.network(
                                      article.urlToImage,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            SizedBox(width: 16),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    formattedTime,
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                  Text(
                                    article.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Color(0xffFF8F0E),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    article.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white54),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
