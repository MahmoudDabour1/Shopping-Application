import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final navigatorKey = GlobalKey<NavigatorState>();


 navigatorTo({required BuildContext context, required Widget page, bool withHistory = false}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}




showMessage({required String msg}) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      backgroundColor: Colors.grey.withOpacity(0.5),
      elevation: 0,
      content: Expanded(
        child: Row(
          children:  [
            const Icon(
              Icons.message_outlined,
              color: Colors.black,
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  msg,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}