import 'package:flutter_faded_list_example/second_page.dart';
import 'package:flutter_faded_list_example/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faded_list/flutter_faded_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Faded List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const FirstPage(
          title: "Flutter Faded List",
        ));
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.format_textdirection_l_to_r),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SecondPage(title: title)),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text("TextDirection  LTR"),
            DirectionWidget(
              textDirection: TextDirection.ltr,
              child: FadedHorizontalList(
                blankSpaceWidth: 200,
                bodyColor: const Color(0xffAD4516),
                imageWidget: Image.network(
                    "https://images.unsplash.com/photo-1561336313-0bd5e0b27ec8?ixlib=rb-1.2.1&raw_url=true&q=80&fm=jpg&crop=entropy&cs=tinysrgb&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170"),
                children: [
                  for (var i = 0; i < 10; ++i)
                    const FadedSampleItem(hotDrink: HotDrink.coffee)
                ],
              ),
            ),
            DirectionWidget(
              textDirection: TextDirection.ltr,
              child: FadedHorizontalList(
                headerColor: const Color(0xffAD4516),
                blankSpaceWidth: 200,
                bodyColor: const Color(0xffd27900),
                borderRadius: 20.0,
                imageWidget: Image.network(
                    "https://images.unsplash.com/photo-1561336313-0bd5e0b27ec8?ixlib=rb-1.2.1&raw_url=true&q=80&fm=jpg&crop=entropy&cs=tinysrgb&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170"),
                headerWidget: const FadedSampleHeaderWidget(
                    hotDrink: HotDrink.coffee, color: Color(0xffAD4516)),
                children: [
                  for (var i = 0; i < 10; ++i)
                    const FadedSampleItem(hotDrink: HotDrink.coffee)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
