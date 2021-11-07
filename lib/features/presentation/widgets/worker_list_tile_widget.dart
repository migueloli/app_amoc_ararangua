import 'package:flutter/material.dart';

class WorkerListTileWidget extends StatelessWidget {
  final Widget icon;
  final String name;
  final String phone;
  final String email;
  final VoidCallback? onLongPress;

  const WorkerListTileWidget({
    Key? key,
    required this.icon,
    required this.name,
    required this.phone,
    required this.email,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );
    const othersStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    return InkWell(
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 16,),
            Column(
              children: [
                if(name.isNotEmpty) Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    name,
                    style: titleStyle,
                  ),
                ),
                if(email.isNotEmpty) Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    email,
                    style: othersStyle,
                  ),
                ),
                if(phone.isNotEmpty) Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    phone,
                    style: othersStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
