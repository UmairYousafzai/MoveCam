import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch(
      {
      required this.isChecked,
      required this.onChanged,
      super.key});

  final bool? isChecked;
  final void Function(bool) onChanged;

  @override
  State<StatefulWidget> createState() {
    return CustomSwitchState();
  }
}

class CustomSwitchState extends State<CustomSwitch> {
  late bool? isChecked;



  @override
  Widget build(BuildContext context) {
    isChecked = widget.isChecked;

    return Transform.scale(
      scale: 0.8,
      child: Switch(
        value: isChecked?? false,
        onChanged: (isChecked) {
          setState(() {
            if (!(this.isChecked ?? false)) {
              this.isChecked = isChecked;
              widget.onChanged(isChecked);
            }
          });
        },
      ),
    );
  }
}
