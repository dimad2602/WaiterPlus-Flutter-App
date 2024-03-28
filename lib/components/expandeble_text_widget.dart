import 'package:flutter/material.dart';
import 'package:flutter_app_for_customers/utils/app_colors.dart';
import '../components/big_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final double screenHeight;

  const ExpandableTextWidget(
      {super.key, required this.text, required this.screenHeight});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firsHalf;
  late String secondHalf;

  bool hiddenText = true;

  @override
  void initState() {
    double textHeight = widget.screenHeight / 5.63;
    super.initState();
    if (widget.text.length > textHeight) {
      firsHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firsHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? BigText(size: 14, text: firsHalf)
          : Column(
              children: [
                BigText(
                    height: 1.8,
                    color: Colors.black87,
                    size: 18,
                    maxLines: 10,
                    text: hiddenText
                        ? ("$firsHalf...")
                        : (firsHalf + secondHalf)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      const BigText(
                        text: 'Ещё',
                        color: AppColors.bottonColor,
                        size: 16,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.bottonColor,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
