import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/news_categories_model.dart';
import 'package:news_app/view/news_details_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';

class NewsCategories extends StatefulWidget {
  const NewsCategories({super.key});

  @override
  State<NewsCategories> createState() => _NewsCategoriesState();
}

class _NewsCategoriesState extends State<NewsCategories> {
  final format = DateFormat('MMMM dd, yyyy');
  NewsViewModel newsViewModel = NewsViewModel();
  String category = 'General';
  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.06,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      category = categoriesList[index];
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Container(
                        height: 100,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: categoriesList[index].toString() == category
                                ? Colors.blue
                                : Colors.grey),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            categoriesList[index].toString(),
                            style: GoogleFonts.roboto(
                                fontSize: 16, color: Colors.white),
                          ),
                        )),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: FutureBuilder<NewsCategoriesModel>(
                future: newsViewModel.fetchNewsCategories(category, context),
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
                    return ListView.builder(
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
                                        borderRadius: BorderRadius.circular(15),
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
                                                snapshot.data!.articles![index]
                                                    .title
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
                        }));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
