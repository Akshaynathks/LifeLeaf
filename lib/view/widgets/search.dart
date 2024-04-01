import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  const CustomSearchBar({
    Key? key,
    required this.onSearch,
    required this.searchController,
  }) : super(key: key);

  final void Function(String) onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0, top: 5.0),
      child: SizedBox(
        height: 50,
        width: 340,
        child: Animate(
          effects: [
            FadeEffect(duration: 200.ms),
            const SlideEffect(curve: Curves.easeIn, duration: Durations.long3),
            // const FlipEffect(curve: Curves.easeIn)
          ],
          child: CupertinoSearchTextField(
            controller: searchController,
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            prefixIcon: const Icon(Icons.search,
                color: Color.fromARGB(255, 227, 251, 92)),
            placeholder: 'Search...',
            itemColor: Color.fromARGB(255, 255, 255, 255),
            style: const TextStyle(color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            borderRadius: BorderRadius.circular(10.0),
            onChanged: onSearch,
          ),
        ),
      ),
    );
  }
}
