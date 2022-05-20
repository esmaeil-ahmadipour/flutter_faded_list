import 'package:flutter/material.dart';

class FadedSampleHeaderWidget extends StatelessWidget {
  const FadedSampleHeaderWidget({
    Key? key,
    required this.hotDrink,
    required this.color,
  }) : super(key: key);
  final HotDrink hotDrink;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                hotDrink == HotDrink.coffee
                    ? "Coffee Category"
                    : "دسته بندی چای",
                style: TextStyle(
                    color: color.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                hotDrink == HotDrink.coffee ? "ALL " : " همه",
                style: TextStyle(
                    color: color.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Icon(Icons.arrow_forward_ios,
                  size: 20,
                  color: color.computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white),
            ],
          ),
        ),
        const Divider(height: 0),
      ],
    );
  }
}

class FadedSampleItem extends StatelessWidget {
  const FadedSampleItem({
    Key? key,
    required this.hotDrink,
  }) : super(key: key);
  final HotDrink hotDrink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          top: 24, bottom: 24, start: 4.0, end: 4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: hotDrink == HotDrink.coffee
              ? Colors.brown.shade900
              : Colors.green.shade900,
        ),
        child: hotDrink == HotDrink.coffee
            ? const Icon(Icons.coffee, color: Colors.white, size: 48)
            : const Icon(Icons.coffee_outlined, color: Colors.white, size: 48),
        width: 100,
        height: 100,
      ),
    );
  }
}

class DirectionWidget extends StatelessWidget {
  const DirectionWidget({
    Key? key,
    required this.child,
    required this.textDirection,
  }) : super(key: key);
  final Widget child;
  final TextDirection textDirection;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: textDirection,
      child: Padding(padding: const EdgeInsets.all(8.0), child: child),
    );
  }
}

enum HotDrink { coffee, tea }

enum LanguageType { rtl, ltr }
