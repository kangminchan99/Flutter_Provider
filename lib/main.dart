import 'package:flutter/material.dart';
import 'package:flutter_provider/model/fish_model.dart';
import 'package:flutter_provider/model/seafish_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// Provider - 데이터를 필요로 하는 위젯들보다 상위에 위치해야함
  @override
  Widget build(BuildContext context) {
    // MultiProvider - 두 개의 다른 타입의 ChangeNotifierProvider가 존재하고  한 위젯에서 이 모두에게 접근하기 위해 사용하는 방법
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            // create메서드를 통해서 FishModel 클래스를 리턴해주면,  Provider의 child가 된
            // MaterialApp아래의 모든 위젯에서 FishModel인스턴스에 접근 가능
            create: (context) =>
                FishModel(name: "Salmon", number: 10, size: 'big')),
        ChangeNotifierProvider(
            create: (context) =>
                SeaFishModel(name: "Tuan", tunaNumber: 0, size: 'middle')),
      ],
      child: MaterialApp(
        home: FishOrder(),
      ),
    );
  }
}

class FishOrder extends StatelessWidget {
  const FishOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
      ),
      body: Center(
        child: Column(
          children: [
            // FishModel인스턴스에 접근 가능
            // of 메서드 - 주어진 context를 거슬러 올라가면서  가장 가까이에 있는 원하는 타입의 인스턴스를 찾아서 반환해라.
            Text('Fish name: ${Provider.of<FishModel>(context).name}'),
            const SizedBox(height: 20),
            const High(),
          ],
        ),
      ),
    );
  }
}

class High extends StatelessWidget {
  const High({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('SpicyA is located at high place'),
        SizedBox(height: 20),
        SpicyA(),
      ],
    );
  }
}

class SpicyA extends StatelessWidget {
  const SpicyA({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Fish Number:${Provider.of<FishModel>(context).number}'),
        Text('Fish Size${Provider.of<FishModel>(context).size}'),
        const SizedBox(height: 20),
        const Middle(),
      ],
    );
  }
}

class Middle extends StatelessWidget {
  const Middle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('SpicyB is located at middle place'),
        SizedBox(height: 20),
        SpicyB(),
      ],
    );
  }
}

class SpicyB extends StatelessWidget {
  const SpicyB({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('TunaNumber${Provider.of<SeaFishModel>(context).tunaNumber}'),
        Text('Size${Provider.of<FishModel>(context).size}'),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              Provider.of<SeaFishModel>(context, listen: false)
                  .changeSeaFishNumber();
            },
            child: const Text('Sea Fish Number')),
        const Low(),
      ],
    );
  }
}

class Low extends StatelessWidget {
  const Low({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('SpicyC is located at low place'),
        SizedBox(height: 20),
        SpicyC(),
      ],
    );
  }
}

class SpicyC extends StatelessWidget {
  const SpicyC({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Number${Provider.of<FishModel>(context).number}'),
        Text('Size${Provider.of<FishModel>(context).size}'),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // FishModel 인스턴스에 접근한다음 숫자를 1씩증가시켜준다.
            Provider.of<FishModel>(context, listen: false).changeFishNumber();
          },
          child: const Text('change Fish Number'),
        )
      ],
    );
  }
}
