class BagModel {
  String name;
  List<BagsList> list;
  BagModel({required this.name, required this.list});
}

class BagsList {
  final String name;
  final String image;
  BagsList({required this.name, required this.image});
}
