import 'package:flutter/material.dart';

// with ChangeNotifier - ChangeNotifier를 mixin했다(FishModel의 어떤 기능이 필요하다).
// FishModel클래스 내에 있는 데이터가 변하였을 때 다른 위젯들에게 자동으로 변한것을 알려주고,
// ui를 리빌드 시켜주기 위해 ChangeNotifier클래스가 필요하다

// ChangeNotifier클래스는 매번 수동으로 addListener를 등록하고, 제거해야 하고  FishModel 인스턴스를 매번
// 생성자를 통해서 전달, UI리빌드도 수동으로 해야하는 단점이 있기 때문에 ChangeNotifierProvider를 사용

// ChangeNotifierProvider의 장점 - 모든 위젯들이 listen할 수 있는 ChangeNotifier 인스턴스 생성
// 자동으로 필요없는 ChangeNotifier제거, Provider.of를 통해 위젯들이 쉽게 ChangeNotifier인스턴스에 접근가능
// 필요시 UI리빌드 가능, 리빌드가 필요없는 경우 listen:false 기능 제공
class FishModel with ChangeNotifier {
  // 생선 이름, 개수, 크기
  final String name;
  int number;
  final String size;

  FishModel({required this.name, required this.number, required this.size});

  void changeFishNumber() {
    number++;
    // ChangeNotifier를 mixin해주었기 때문에 notifyListeners메서드 호출 가능
    notifyListeners();
  }
}
