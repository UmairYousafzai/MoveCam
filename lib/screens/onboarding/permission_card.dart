
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/custom_switch.dart';

class PermissionCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;
  final bool? isChecked;
  final void Function(bool) onChanged;

  const PermissionCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
            CustomSwitch(isChecked: isChecked, onChanged:onChanged),
          ],
        ),
      ),
    );
  }
}
