import 'package:assignment/model/category_model.dart';
import 'package:assignment/model/product_model.dart';
import 'package:assignment/services/base_client.dart';
import 'package:assignment/style/app_images.dart';
import 'package:assignment/utils/utils.dart';
import 'package:flutter/material.dart';

class CourseProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  int currentIndex = 0;
  int minPrice = 90;
  int maxPrice = 200;
  TextEditingController searchC = TextEditingController();
  String title = "All";
  List items = [
    {"title": "Language", "image": AppImages.womenBImg},
    {"title": "Painting", "image": AppImages.womenPImg}
  ];

  List btnList = [
    {"title": "All"},
    {"title": "Popular"},
    {"title": "New"},
  ];
  List<Product> filterList = [];
  List<Product> productList = [];
  List<Product> popularProductList = [];
  List<Product> newProductList = [];

  List newItemsList = [];
  List<String> categoriesList = [];
  List<String> durationsList = [
    '3-8 Hours',
    '8-14 Hours',
    '14-20 Hours',
    '20-24 Hours',
    '24-30 Hours'
  ];
  List<String> selectedCategories = [];
  List<String> selectedDurations = [];

  void selectCotegoryItems(bool selected, String category) {
    if (selected) {
      selectedCategories.add(category);
    } else {
      selectedCategories.remove(category);
    }
    notifyListeners();
  }

  void selectDurationItems(bool selected, String category) {
    if (selected) {
      selectedDurations.add(category);
    } else {
      selectedDurations.remove(category);
    }
    notifyListeners();
  }

  void assignIndex(int index, String lable) {
    currentIndex = index;
    title = lable;
    notifyListeners();
  }

  selectPriceRange(values) {
    minPrice = values.start.round();
    maxPrice = values.end.round();
    notifyListeners();
  }

  clearFilters() {
    selectedCategories.clear();
    selectedDurations.clear();
    minPrice = 0;
    maxPrice = 0;
    notifyListeners();
  }

  searchTasks(List<Product> itemList, List<Product> filterList) {
    String searchText = searchC.text.toLowerCase();

    if (searchText.isNotEmpty) {
      filterList.clear();
      filterList.addAll(itemList.where((item) =>
          item.title.toLowerCase().contains(searchText) ||
          item.description.toLowerCase().contains(searchText)));
    } else {
      filterList.clear();
      filterList.addAll(itemList);
    }

    notifyListeners();
  }

  void resetProductList(List<Product> taskList, List<Product> filterList) {
    searchC.clear();
    filterList.clear();
    filterList.addAll(taskList);
    notifyListeners();
  }

  Future<void> getApiProducts(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    String url = "https://dummyjson.com/products";

    try {
      var response = await BaseClient.getRequestWithoutAuthentication(url);
      debugPrint("Url: $url");
      debugPrint("Response after postRequest: $response");
      if (response == null) {
        Utils.errorMessage(context, "Received null response from server.");
        _isLoading = false;
        notifyListeners();
        return;
      }

      var responseModel = productResponseModelFromJson(response);

      if (responseModel != null) {
        productList.clear();
        productList.addAll(responseModel.products);

        debugPrint("Product List Length: ${productList.length}");
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      Utils.errorMessage(context, e.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getApiCotegory(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    String url = "https://dummyjson.com/products/category-list";

    try {
      var response = await BaseClient.getRequestWithoutAuthentication(url);
      debugPrint("Url: $url");
      debugPrint("Response after postRequest: $response");
      if (response == null) {
        Utils.errorMessage(context, "Received null response from server.");
        _isLoading = false;
        notifyListeners();
        return;
      }

      var responseModel = categoryResponseModelFromJson(response);

      if (responseModel != null) {
        categoriesList.clear();
        categoriesList.addAll(responseModel);

        debugPrint("Product List Length: ${productList.length}");
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      Utils.errorMessage(context, e.toString());
      _isLoading = false;
      notifyListeners();
    }
  }
}
