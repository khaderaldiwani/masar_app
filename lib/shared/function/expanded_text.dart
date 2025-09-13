
import 'package:flutter/material.dart';

Widget buildExpandableText(String text, {int maxChars = 100,required TextStyle style}) {
  return _ExpandableText(text: text, maxChars: maxChars,style:style ,);
}

class _ExpandableText extends StatefulWidget {
  final String text;
  final int maxChars;
  final TextStyle style;

  const _ExpandableText({Key? key, required this.text, required this.maxChars, required this.style}) : super(key: key);

  @override
  State<_ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<_ExpandableText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final bool isLong = widget.text.length > widget.maxChars;
    final String displayText = _expanded || !isLong
        ? widget.text
        : widget.text.substring(0, widget.maxChars) + "...";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(displayText,style: widget.style,),
        if (isLong)
          GestureDetector(
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
            child: Text(
              _expanded ? "عرض أقل" : "عرض المزيد",
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
