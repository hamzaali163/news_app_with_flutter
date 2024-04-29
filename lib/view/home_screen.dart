import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/news_categories_model.dart';
import 'package:news_app/model/news_headlines_model.dart';
import 'package:news_app/repository/api_urls.dart';
import 'package:news_app/repository/news_repository.dart';
import 'package:news_app/utils/route_names.dart';
import 'package:news_app/view/news_details_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum NewsChannel { bbc, aljazeera, bloomberg }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  ApiUrls apiUrls = ApiUrls();
  final format = DateFormat('MMMM dd, yyyy');
  dynamic submitresult = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.categoriesScreen);
              },
              icon: Image.asset(
                'images/category_icon.png',
                height: 30,
                width: 30,
              )),
          centerTitle: true,
          title: Text(
            'Top News',
            style:
                GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                NewsRepository()
                    .fetchNewsHeadlines('al-jazeera-english', context);
                setState(() {
                  submitresult = value;
                });
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'bbc-news', child: Text('BBC')),
                const PopupMenuItem(
                    value: 'al-jazeera-english', child: Text('Al-Jazeera')),
                const PopupMenuItem(
                    value: 'business-insider', child: Text('Business Insider')),
                const PopupMenuItem(value: 'cnn', child: Text('CNN')),
                const PopupMenuItem(value: 'fox-news', child: Text('Fox News')),
                const PopupMenuItem(value: 'ary-news', child: Text('ARY NEWS')),
              ],
            ),
          ],
        ),
        body: ListView(
          children: [
            FutureBuilder<NewsHeadlinesModel>(
              future: newsViewModel.fetchNewsHeadlines(submitresult, context),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SpinKitWanderingCubes(
                    size: 50,
                    color: Colors.blue,
                  );
                } else if (snapshot.data == null) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('')],
                  );
                } else {
                  return SizedBox(
                    height: height * 0.47,
                    child: ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: height * 0.02),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return NewsDetails(
                                    date: snapshot
                                        .data!.articles![index].publishedAt
                                        .toString(),
                                    headline: snapshot
                                        .data!.articles![index].title
                                        .toString(),
                                    imageurl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    source: snapshot
                                        .data!.articles![index].source!.id
                                        .toString(),
                                    description: snapshot
                                        .data!.articles![index].description
                                        .toString(),
                                  );
                                },
                              ));
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: height * .37,
                                      height: height * 0.5,
                                      placeholder: (context, url) =>
                                          const SpinKitFadingCircle(
                                            color: Colors.blue,
                                          ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString()),
                                ),
                                Positioned(
                                  left: 7,
                                  right: 7,
                                  bottom: 20,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    width: width * .77,
                                    height: height * .22,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                style: GoogleFonts.roboto(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                style: GoogleFonts.roboto(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: height * 0.77,
              child: FutureBuilder<NewsCategoriesModel>(
                future: newsViewModel.fetchNewsCategories('general', context),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SpinKitWanderingCubes(
                      size: 50,
                      color: Colors.blue,
                    );
                  } else if (snapshot.data == null) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_sharp,
                          color: Colors.red,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Error'),
                        Text('No Internet Connection Found')
                      ],
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: height * 0.02),
                      child: ListView.builder(
                          // shrinkWrap: true,
                          //   scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: ((context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return NewsDetails(
                                        date: snapshot
                                            .data!.articles![index].publishedAt
                                            .toString(),
                                        headline: snapshot
                                            .data!.articles![index].title
                                            .toString(),
                                        imageurl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        source: snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        description: snapshot
                                            .data!.articles![index].description
                                            .toString(),
                                      );
                                    },
                                  ));
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              width: height * .18,
                                              height: height * .3,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                    child: SpinKitFadingCircle(
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                        Icons.error,
                                                        color: Colors.red,
                                                      ),
                                              imageUrl: snapshot.data!
                                                  .articles![index].urlToImage
                                                  .toString()),
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                          height: height * 0.28,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: width * 0.03),
                                                child: Text(
                                                  snapshot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  maxLines: 3,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: width * 0.03),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      flex: 2,
                                                      child: Text(
                                                        snapshot
                                                            .data!
                                                            .articles![index]
                                                            .source!
                                                            .name
                                                            .toString(),
                                                        maxLines: 3,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color:
                                                                    Colors.blue,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 1,
                                                      child: Text(
                                                        format.format(dateTime),
                                                        maxLines: 3,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
