import 'package:flutter/material.dart';
import 'package:teego/view/widgets/base_scaffold.dart';

class TrendingView extends StatefulWidget {
  const TrendingView({Key? key}) : super(key: key);


  @override
  State<TrendingView> createState() => _TrendingView();
}

class _TrendingView extends State<TrendingView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
            child: Text(
              "Trending screen",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ))
      ],
    );
  }
}
