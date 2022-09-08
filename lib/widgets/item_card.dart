import 'package:flutter/material.dart';

import '../models/item.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key, required this.item}) : super(key: key);
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      width: 340,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Stack(
        children: [
          Positioned.fill(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(item.imageURL, fit: BoxFit.fitHeight))),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Color.fromARGB(0, 27, 25, 25),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.1, 0.9],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(item.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0)),
                    const SizedBox(height: 5.0),
                    Text(item.description,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0)),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
