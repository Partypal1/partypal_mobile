import 'package:go_router/go_router.dart';

extension ClearAndNavigate on GoRouter{
  void clearAndNavigate(String location){
    while(canPop()){
      pop();
    }
    pushReplacement(location);
  }
}