import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperhub/data/category_data.dart';
import 'package:wallpaperhub/model/categories_model.dart';
import 'package:wallpaperhub/model/wallpaper_model.dart';
import 'package:wallpaperhub/ui/widgets/widget.dart';

class Categories extends StatefulWidget {
  final String categorieName;
  Categories({this.categorieName});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpaper = [];
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              mainHeading('CATEGORIES'),
              SizedBox(
                height: 2.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                child: ListView.builder(
                    controller: _controller,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoriesTile(
                          imgUrl: categories[index].imgUrl,
                          title: categories[index].categoriesName);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
