class ApiUrls {
  dynamic headlinesURl;
  void getchannelname(dynamic newsname) {
    headlinesURl =
        'https://newsapi.org/v2/top-headlines?sources=${newsname}&apiKey=93fb73d53d94436f88cf7ef4a04b3e7e';
  }
}
