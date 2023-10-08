import 'package:flutter/material.dart';

import '../components/Small_text.dart';
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

  //final constants = Constants(screenHeight: MediaQuery.of(context).size.height, screenWidth: MediaQuery.of(context).size.width);

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
          ? SmollText(size: Constants.font16, text: firsHalf)
          : Column(
              children: [
                SmollText(height: 1.8,color: Colors.black87, size: Constants.font16, text: hiddenText
                    ? (firsHalf + "...")
                    : (firsHalf + secondHalf)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText=!hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmollText(text:
                        'Show more', color: Color(0xFF4ecb71),
                        ),
                      Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,
                        color: Color(0xFF4ecb71),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
