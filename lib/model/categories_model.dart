import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wallpaperhub/ui/screens/search/after_search.dart';

class CategoriesModel {
  String categoriesName;
  String imgUrl;
}

class CategoriesTile extends StatefulWidget {
  final String imgUrl, title;
  CategoriesTile({@required this.imgUrl, @required this.title});

  @override
  _CategoriesTileState createState() => _CategoriesTileState();
}

class _CategoriesTileState extends State<CategoriesTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            maintainState: true,
            builder: (context) => Search(
              searchQuery: widget.title,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 10, bottom: 10),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.imgUrl,
                height: 20.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black38,
              ),
              alignment: Alignment.center,
              height: 20.h,
              width: double.infinity,
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
