import 'package:flutter/material.dart';
import 'package:flutter_project2/util/AppColors.dart';

import '../components/Small_text.dart';
import '../components/big_text.dart';
import 'constants.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;

  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firsHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = Constants.screenHeight / 5.63;

  @override
  void initState() {
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
          ? SmollText(size: Constants.font20, text: firsHalf)
          : Column(
              children: [
                SmollText(height: 1.8,color: Colors.black87, size: Constants.font20, text: hiddenText
                    ? ("$firsHalf...")
                    : (firsHalf + secondHalf)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText=!hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      BigText(text:
                        'Ещё', color: AppColors.bottonColor, size: Constants.font20*0.9,
                        ),
                      Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,
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
