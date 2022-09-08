import 'package:flutter/material.dart';
import '/widgets/item_card.dart';
import '/widgets/item_tag.dart';
import '../main.dart';
import '../models/item.dart';

class DragableWidget extends StatefulWidget {
  const DragableWidget(
      {Key? key,
      required this.item,
      required this.index,
      required this.swipeValueNotifier,
      this.isLastCard = false})
      : super(key: key);
  final Item item;
  final int index;
  final ValueNotifier<SwipeValue> swipeValueNotifier;
  final bool isLastCard;
  @override
  State<DragableWidget> createState() => _DragableWidgetState();
}

class _DragableWidgetState extends State<DragableWidget> {
  ValueNotifier<SwipeValue> swipeValueNotifier = ValueNotifier(SwipeValue.none);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Draggable<int>(
      data: widget.index,
      feedback: Material(
        color: Colors.transparent,
        child: ValueListenableBuilder(
          valueListenable: widget.swipeValueNotifier,
          builder: (context, swipe, _) => RotationTransition(
            turns: widget.swipeValueNotifier.value != SwipeValue.none
                ? widget.swipeValueNotifier.value == SwipeValue.left
                    ? const AlwaysStoppedAnimation(-15 / 360)
                    : const AlwaysStoppedAnimation(15 / 360)
                : const AlwaysStoppedAnimation(0),
            child: Stack(
              children: [
                ItemCard(item: widget.item),
                swipe != SwipeValue.none
                    ? swipe == SwipeValue.right
                        ? Positioned(
                            top: 40.0,
                            left: 20.0,
                            child: Transform.rotate(
                                angle: 12,
                                child: const ItemTag(
                                  text: "LIKE",
                                  color: Color.fromARGB(255, 145, 231, 32),
                                )))
                        : Positioned(
                            top: 50,
                            right: 24,
                            child: Transform.rotate(
                              angle: -12,
                              child: const ItemTag(
                                  text: "NOPE", color: Colors.red),
                            ))
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
      onDragUpdate: (DragUpdateDetails dragUpdateDetails) {
        if (dragUpdateDetails.delta.dx > 0 &&
            dragUpdateDetails.globalPosition.dx >
                MediaQuery.of(context).size.width / 2) {
          swipeValueNotifier.value =
              SwipeValue.right; //draggable widget is dragged to right
        }
        if (dragUpdateDetails.delta.dx < 0 &&
            dragUpdateDetails.globalPosition.dx <
                MediaQuery.of(context).size.width / 2) {
          swipeValueNotifier.value =
              SwipeValue.left; //draggable widget is dragged to left
        }
      },
      onDragEnd: (drag) {
        swipeValueNotifier.value = SwipeValue.none;
      },
      childWhenDragging: Container(
        color: Colors.transparent,
      ),
      child: ValueListenableBuilder(
          valueListenable: widget.swipeValueNotifier,
          builder:
              (BuildContext context, SwipeValue swipeValue, Widget? child) {
            return Stack(
              children: [
                ItemCard(item: widget.item),
                // heck if this is the last card and Swipe is not equal to Swipe.none
                swipeValue != SwipeValue.none && widget.isLastCard
                    ? swipeValue == SwipeValue.right
                        ? const Positioned(
                            top: 40,
                            left: 30,
                            child: ItemTag(
                              text: 'LIKE',
                              color: Color.fromARGB(255, 145, 231, 32),
                            ),
                          )
                        : Positioned(
                            top: 50,
                            right: 24,
                            child: ItemTag(
                              text: 'NOPE',
                              color: Colors.red[400]!,
                            ),
                          )
                    : const SizedBox.shrink(),
              ],
            );
          }),
    ));
  }
}
