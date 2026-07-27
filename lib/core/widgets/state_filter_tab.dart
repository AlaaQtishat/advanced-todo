import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/widgets/customized_elevated_button.dart';

class StateFilterTab extends StatefulWidget {
  const StateFilterTab({super.key});

  @override
  State<StateFilterTab> createState() => _StateFilterTabState();
}

class _StateFilterTabState extends State<StateFilterTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomizedElevatedButton(
                text: "All",
                fontSize: 20.sp,
                onPressed: () {},
                color: Colors.white,
                textColor: Color(0xFF7008E7),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomizedElevatedButton(
                text: "Active",
                fontSize: 20.sp,
                onPressed: () {},
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomizedElevatedButton(
                text: "Done",
                fontSize: 20.sp,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
