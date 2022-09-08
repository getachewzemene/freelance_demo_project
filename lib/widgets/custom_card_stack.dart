import 'package:flutter/material.dart';
import 'package:freelance_demo_app/widgets/bottom_navbar.dart';
import '/main.dart';
import '/widgets/dragable_widget.dart';
import '../models/item.dart';

class CustomCardStack extends StatefulWidget {
  const CustomCardStack({Key? key}) : super(key: key);

  @override
  State<CustomCardStack> createState() => _CustomCardStackState();
}

class _CustomCardStackState extends State<CustomCardStack>
    with SingleTickerProviderStateMixin {
  List<Item> itemList = [
    const Item(
        imageURL: "assets/images/image1.jpg",
        title: "Kristin Watson,24",
        description: "Lives in Portland, lllinois \n 15 miles away"),
    const Item(
        imageURL: "assets/images/image1.jpg",
        title: "Kristin Watson,24",
        description: "Lives in Portland, lllinois \n 15 miles away"),
    const Item(
        imageURL: "assets/images/image2.jpeg",
        title: "Jane Cooper,25",
        description: "Lives in Portland, lllinois \n 11 miles away"),
  ];
  ValueNotifier<SwipeValue> swipeValueNotifier = ValueNotifier(SwipeValue.none);
  late final AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        itemList.removeLast();
        _animationController.reset();
        swipeValueNotifier.value = SwipeValue.none;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: SizedBox(
                height: 500.0,
                child: ValueListenableBuilder(
                  valueListenable: swipeValueNotifier,
                  builder: (context, swipe, _) => Stack(
                    alignment: Alignment.center,
                    children: List.generate(itemList.length, (index) {
                      if (index == itemList.length - 1) {
                        return PositionedTransition(
                          rect: RelativeRectTween(
                            begin: RelativeRect.fromSize(
                                const Rect.fromLTWH(0, 0, 560, 370),
                                const Size(560, 370)),
                            end: RelativeRect.fromSize(
                                Rect.fromLTWH(
                                    swipe != SwipeValue.none
                                        ? swipe == SwipeValue.left
                                            ? -300
                                            : 300
                                        : 0,
                                    0,
                                    560,
                                    370),
                                const Size(560, 370)),
                          ).animate(CurvedAnimation(
                            parent: _animationController,
                            curve: Curves.easeInOut,
                          )),
                          child: RotationTransition(
                            turns: Tween<double>(
                                    begin: 0,
                                    end: swipe != SwipeValue.none
                                        ? swipe == SwipeValue.left
                                            ? -0.1 * 0.3
                                            : 0.1 * 0.3
                                        : 0.0)
                                .animate(
                              CurvedAnimation(
                                parent: _animationController,
                                curve: const Interval(0, 0.4,
                                    curve: Curves.easeInOut),
                              ),
                            ),
                            child: DragableWidget(
                              item: itemList[index],
                              index: index,
                              swipeValueNotifier: swipeValueNotifier,
                              isLastCard: true,
                            ),
                          ),
                        );
                      } else {
                        return DragableWidget(
                          item: itemList[index],
                          index: index,
                          swipeValueNotifier: swipeValueNotifier,
                        );
                      }
                    }),
                  ),
                ),
              ),
            ),
            Positioned(
                right: 0,
                child: DragTarget<int>(
                  builder: (BuildContext context, List<dynamic> accepted,
                      List<dynamic> rejected) {
                    return IgnorePointer(
                        child: Container(
                      height: 700.0,
                      width: 60.0,
                      color: Colors.transparent,
                    ));
                  },
                  onAccept: (int index) {
                    setState(() {
                      itemList.removeAt(index);
                    });
                  },
                )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BottomNavBar(
                  onPressed: () {
                    swipeValueNotifier.value = SwipeValue.left;
                    _animationController.forward();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  color: Colors.red,
                  width: 70.0,
                  height: 70.0),
              const SizedBox(width: 20),
              BottomNavBar(
                onPressed: () {
                  swipeValueNotifier.value = SwipeValue.none;
                  _animationController.forward();
                },
                icon: const Icon(
                  Icons.star,
                  size: 25.0,
                  color: Colors.blue,
                ),
                color: Colors.blue,
                width: 60.0,
                height: 60.0,
              ),
              const SizedBox(width: 20),
              BottomNavBar(
                  onPressed: () {
                    swipeValueNotifier.value = SwipeValue.right;
                    _animationController.forward();
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.green,
                  ),
                  color: Colors.green,
                  width: 70.0,
                  height: 70.0),
            ],
          ),
        ),
      ],
    );
  }
}
