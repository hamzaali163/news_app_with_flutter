import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetails extends StatefulWidget {
  final String headline;
  final String imageurl;
  final String source;
  final String description;
  final String date;

  const NewsDetails(
      {super.key,
      required this.headline,
      required this.imageurl,
      required this.source,
      required this.description,
      required this.date});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(widget.date);
    final height = MediaQuery.sizeOf(context).height * 1;
    //  final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Container(
              height: height * .45,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.imageurl,
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(
                      Icons.error_rounded,
                      color: Colors.red,
                    ),
                  ),
                  placeholder: (context, url) {
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * .35),
              height: height * 0.6,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 13, right: 10, top: height * 0.04),
                child: ListView(
                  children: [
                    Text(
                      widget.headline,
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.source,
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                        Flexible(
                          child: Text(
                            format.format(dateTime),
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Text(
                      widget.description,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
