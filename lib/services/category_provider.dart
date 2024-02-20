import 'package:flutter/material.dart';
import 'package:partypal/models/category_model.dart';

class CategoryProvider extends ChangeNotifier{
  List<Category> categories = [];
  bool isFetching = false;

  void fetchCategories() async{
    isFetching = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    categories = [
      Category(
        name: 'Clubs',
        desciption: 'Nightlife',
        imageUrl: 'https://file.visittallinn.ee/5zkas9/clubstudio.jpg'
      ),
      Category(
        name: 'Beach',
        desciption: 'Beach vibes',
        imageUrl: 'https://i0.wp.com/blog.bambatravel.com/wp-content/uploads/2015/08/Ibiza-Spain-e1438694304394.jpg?fit=800%2C470&ssl=1'
      ),
      Category(
        name: 'Bars and lounges',
        desciption: 'Bars',
        imageUrl: 'https://imgproxy.ra.co/_/quality:66/aHR0cHM6Ly9zdGF0aWMucmEuY28vaW1hZ2VzL2NsdWJzL2xnL3N1bnMtYmFyLWxvdW5nZS0xMTEyODBfODAwLmpwZz9kYXRlVXBkYXRlZD0xNDY2MDc4MTY1MjMz'
      ),
    ];
    isFetching = false;
    notifyListeners();
  }
  
}