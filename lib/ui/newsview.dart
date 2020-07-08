import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercarnewsapp/model/news.dart';
import 'package:fluttercarnewsapp/model/textStyle.dart';
import 'package:http/http.dart'as http;

class NewsView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NewsViewState();
  }

}

class _NewsViewState extends State<NewsView> {

  var baseUrl = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=2259d585e97b40a9b0fbfccc1de7640d";

  CarNews carNews;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(baseUrl);
    var jsonData = json.decode(res.body);

    carNews = CarNews.fromJson(jsonData);
    print(carNews.toString());

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
        appBar: AppBar(
          title: Text('News',style: TextStyle(fontSize: 26,color: Colors.orangeAccent),),
          backgroundColor: Colors.brown,
        ),
        body: carNews == null ?
        Center(
          child: CircularProgressIndicator(),
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            photoList(),
            buttonSeeAll(),
            newsList(),

          ],
        )
    );
  }


  Expanded photoList() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: carNews.articles.length,
          itemBuilder: (context, index){
            return Card(
              child: InkWell(
                child: (carNews.articles[index].urlToImage == null)? Image.network(
                    'https://yt3.ggpht.com/a/AATXAJzP8iiqrbsEgxZHXXZynrPyJGPVbD3o4xIbov9tchg=s900-c-k-c0xffffffff-no-rj-mo')
                : Image.network(
                carNews.articles[index].urlToImage,
              width: 300,
              fit: BoxFit.fill,

              ),
                
                onTap: (){
                  Navigator.push(context,  MaterialPageRoute(builder: (context) => Details(articles: carNews.articles[index],)));

                },

              ));


          }

      )
    );

  }


  Padding buttonSeeAll() {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 15, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Populer'),
            RaisedButton(
              color: Colors.black87,
              child: Text('See All',style: TextStyle(color: Colors.white),),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => newsList()));
              },
            )
          ],
        )
    );
  }

  Expanded newsList() {
    return Expanded(

          child: ListView.builder(
            itemCount: carNews.articles.length,
            itemBuilder: (context, index){
              return Card(
               color: Colors.white70,
                child: ListTile(
                  leading: SizedBox(
                    width: 60,
                    child: (carNews.articles[index].urlToImage == null)
                        ? Image.network(
                        'https://yt3.ggpht.com/a/AATXAJzP8iiqrbsEgxZHXXZynrPyJGPVbD3o4xIbov9tchg=s900-c-k-c0xffffffff-no-rj-mo')
                        : Image.network(
                      carNews.articles[index].urlToImage,
                      width: 100,
                      fit: BoxFit.fill,
                    ),

                  ),
                  title: Text(carNews.articles[index].title),


                  onTap: (){

                    Navigator.push(context,MaterialPageRoute(builder: (context) =>
                    Details(articles: carNews.articles[index]),




                    ));


                  },
                ),

              );

            },
          ),

    );
  }

}


class Details extends StatelessWidget {
Articles articles;

  Details(
      {this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                        height: 400.0,
                        child:  (articles.urlToImage == null)
                            ? Image.network(
                            'https://yt3.ggpht.com/a/AATXAJzP8iiqrbsEgxZHXXZynrPyJGPVbD3o4xIbov9tchg=s900-c-k-c0xffffffff-no-rj-mo')
                            : Image.network(
                          articles.urlToImage,

                          fit: BoxFit.fill,
                        ),
                    ),
                    AppBar(
                      backgroundColor: Colors.transparent,
                      leading: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      elevation: 0, //shadow
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 10.0),
                      Text(articles.title == null
                          ? 'Unknown' : articles.title,
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.2,
                            wordSpacing: 0.6
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(articles.description == null
                          ? 'Unknown' : articles.description,
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 0.2,
                            wordSpacing: 0.3
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(articles.author == null
                              ? 'Unknown' : articles.author,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(articles.publishedAt == null
                              ? 'Unknown' : articles.publishedAt,

                              style: TextStyle(
                                color: Colors.grey,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ],)
        ),
      ),

    );
  }
}


