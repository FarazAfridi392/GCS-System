import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ShopReviewsPage extends StatefulWidget {
  @override
  _ShopReviewsPageState createState() => _ShopReviewsPageState();
}

class _ShopReviewsPageState extends State<ShopReviewsPage> {
  double rating = 0.0;
  List<int> ratings = [2, 1, 5, 2, 4, 3];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          ...ratings
              .map((val) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: CircleAvatar(
                          maxRadius: 14,
                          backgroundImage: AssetImage('assets/background.jpg'),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Rizwan Ullah',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: RatingBar(
                                ignoreGestures: true,
                                itemSize: 20,
                                allowHalfRating: true,
                                initialRating: val.toDouble(),
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                ratingWidget: RatingWidget(
                                  empty: Icon(Icons.favorite_border,
                                      color: Color(0xffFF8993), size: 20),
                                  full: Icon(
                                    Icons.favorite,
                                    color: Color(0xffFF8993),
                                    size: 20,
                                  ),
                                  half: null,
                                ),
                                onRatingUpdate: (value) {
                                  setState(() {
                                    rating = value;
                                  });
                                  print(value);
                                },
                              ),
                            ),
                            Text(
                              'Their products are awesome! ... I always buy from them',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '21 likes',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 10.0),
                                  ),
                                  Text(
                                    '1 Comment',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.0),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )))
              .toList()
        ],
      ),
    );
  }
}
