import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Color begin;
  final Color end;
  final String categoryName;

  CategoryCard({
    Key key,
    this.begin,
    this.end,
    this.categoryName,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [begin, end],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
              alignment: Alignment(-1, 0),
              child: Text(
                categoryName,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'View more',
                  style: TextStyle(color: end, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class StaggeredCardCard extends StatefulWidget {
  final Color begin;
  final Color end;
  final String categoryName;
  final String assetPath;

  const StaggeredCardCard(
      {Key key, this.begin, this.end, this.categoryName, this.assetPath})
      : super(key: key);

  @override
  _StaggeredCardCardState createState() => _StaggeredCardCardState();
}

class _StaggeredCardCardState extends State<StaggeredCardCard>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: CategoryCard(
        categoryName: widget.categoryName,
        begin: widget.begin,
        end: widget.end,
      ),
    );
  }
}
