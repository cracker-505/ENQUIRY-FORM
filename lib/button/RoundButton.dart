import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.loading})
      : super(key: key);
  final String title;
  final VoidCallback onTap;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.black87,
      focusColor: Colors.black87,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: Colors.deepPurple, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
