import 'package:flutter_faded_list_example/main.dart';
import 'package:flutter_faded_list_example/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faded_list/flutter_faded_list.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.format_textdirection_r_to_l),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => FirstPage(title: title)),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text("TextDirection  RTL"),
            DirectionWidget(
              textDirection: TextDirection.rtl,
              child: FadedHorizontalList(
                blankSpaceWidth: 200,
                bodyColor: const Color(0xff044b1f),
                imageWidget: Image.network(
                    "https://images.unsplash.com/photo-1564890369478-c89ca6d9cde9?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170"),
                children: [
                  for (var i = 0; i < 10; ++i)
                    const FadedSampleItem(hotDrink: HotDrink.tea)
                ],
              ),
            ),
            DirectionWidget(
                textDirection: TextDirection.rtl,
                child: FadedHorizontalList(
                  headerColor: const Color(0xff0c4e23),
                  blankSpaceWidth: 200,
                  bodyColor: const Color(0xff00ff12),
                  borderRadius: 20.0,
                  imageWidget: Image.network(
                      "https://images.unsplash.com/photo-1564890369478-c89ca6d9cde9?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170"),
                  headerWidget: const FadedSampleHeaderWidget(
                      hotDrink: HotDrink.tea, color: Color(0xff0c4e23)),
                  children: [
                    for (var i = 0; i < 10; ++i)
                      const FadedSampleItem(hotDrink: HotDrink.tea)
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
