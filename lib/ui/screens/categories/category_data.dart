import 'package:wallpaperhub/ui/screens/categories/categories_model.dart';

String apiKey = '563492ad6f91700001000001b0b10c76c95a4c3d8c0cc474efc09740';

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = [];
  CategoriesModel categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://www.fanbolt.com/storage/2021/08/anime-iphone-wallpaper.jpg';
  categoriesModel.categoriesName = 'Anime';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZGVHyxpnj4z08C5mFDw3fgMhWa76L66p3JA&usqp=CAU';
  categoriesModel.categoriesName = 'Minimalistic';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://4kwallpapers.com/images/walls/thumbs_2t/6409.jpg';
  categoriesModel.categoriesName = 'Dark';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'http://www.cartoondistrict.com/wp-content/uploads/2018/03/Superhero-Wallpapers-For-iPhone1.1.jpg';
  categoriesModel.categoriesName = 'superheroes';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://wallpapers.com/images/high/hd-halo-gaming-cover-j2vgssap7f5e2so1.jpg';
  categoriesModel.categoriesName = 'Gaming';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl =
      'https://i1.wp.com/wallpapersfortech.com/wp-content/uploads/2020/07/img_6528.jpg?resize=480%2C360&ssl=1';
  categoriesModel.categoriesName = 'Cars';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  categoriesModel.imgUrl = 'https://wallpaperaccess.com/full/16389.png';
  categoriesModel.categoriesName = 'Humour';
  categories.add(categoriesModel);
  categoriesModel = CategoriesModel();

  return categories;
}
