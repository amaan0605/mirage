import 'package:wallpaperhub/model/categories_model.dart';

String apiKey = '563492ad6f91700001000001b0b10c76c95a4c3d8c0cc474efc09740';

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = [];
  CategoriesModel categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://media.kasperskydaily.com/wp-content/uploads/sites/92/2014/04/18130043/online-gamer-threats-featured.jpg';
  categoriesModel.categoriesName = 'Gaming';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://cdn.shopify.com/s/files/1/0969/9128/products/Colorful_20Abstract_20Artwork_952b616f-5af3-4b37-9f92-188d915f2fba.jpg?v=1485510306';
  categoriesModel.categoriesName = 'Artwork';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl = 'https://scx2.b-cdn.net/gfx/news/2019/2-nature.jpg';
  categoriesModel.categoriesName = 'Nature';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://cdn.nextgov.com/media/img/cd/2020/10/19/NGspace20201019/860x394.jpg?1618395239';
  categoriesModel.categoriesName = 'Space';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://specials-images.forbesimg.com/imageserve/5d3703e2f1176b00089761a6/960x0.jpg?cropX1=836&cropX2=5396&cropY1=799&cropY2=3364';
  categoriesModel.categoriesName = 'Cars';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl = 'https://i.redd.it/17hi91q4dib71.jpg';
  categoriesModel.categoriesName = 'COMING SOON';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  return categories;
}
