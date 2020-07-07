import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercarnewsapp/model/news.dart';
import 'package:http/http.dart'as http;

class NewsView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NewsViewState();
  }

}

class _NewsViewState extends State<NewsView> {

  var url = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=2259d585e97b40a9b0fbfccc1de7640d";

  CarNews carNews;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var jsonData = json.decode(res.body);

    carNews = CarNews.fromJson(jsonData);

    print(carNews.toString());

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News'),
        ),
        body: carNews == null ?
        Center(
          child: CircularProgressIndicator(),
        ) : Column(
          children: [
            photoList(),
            buttonSeeAll(),
            newsList(),

          ],
        )
    );
  }

  Expanded newsList() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 1,
        children: carNews.articles.map((e) =>
            Padding(
              padding: EdgeInsets.all(0),
              child: InkWell(
                onTap: () {},

                child: Card(
                  child: Row(
                      children: [
                        Container(
                          width: 100.0,
                          height: 100.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(8.0),
                                bottomLeft: const Radius.circular(8.0)
                            ),
                            child: (e.urlToImage == null)
                                ? Image.network(
                                'https://yt3.ggpht.com/a/AATXAJzP8iiqrbsEgxZHXXZynrPyJGPVbD3o4xIbov9tchg=s900-c-k-c0xffffffff-no-rj-mo')
                                : Image.network(
                              e.urlToImage,
                              width: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(e.title),
                            subtitle: Text(e.author == null
                                ? 'Unknown' : e.author),
                          ),
                        )
                      ]
                  ),
                ),
              ),
            )
        ).toList(),
      ),
    );
  }

  Expanded photoList() {
    return Expanded(
      child: Text('hello'),
    );
  }

  Expanded buttonSeeAll() {
    return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Populer'),
            RaisedButton(
              child: Text('See All'),
            )
          ],
        )
    );
  }

}



