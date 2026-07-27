import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/constants/app_themes.dart';
import 'package:todo/core/widgets/customized_elevated_button.dart';

class TypeFilterTab extends StatefulWidget {
  const TypeFilterTab({super.key});

  @override
  State<TypeFilterTab> createState() => _TypeFilterTabState();
}

class _TypeFilterTabState extends State<TypeFilterTab> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Expanded(
            child: CustomizedElevatedButton(
              text: "All",
              onPressed: () {},
              color: AppThemes.primaryPurple,
              textColor: Colors.white,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomizedElevatedButton(
              text: "Work",
              onPressed: () {},
              borderColor: Colors.black26,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomizedElevatedButton(
              text: "Personal",
              onPressed: () {},
              borderColor: Colors.black26,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomizedElevatedButton(
              text: "Shopping",
              onPressed: () {},
              borderColor: Colors.black26,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: CustomizedElevatedButton(
              text: "Study",
              onPressed: () {},
              borderColor: Colors.black26,
            ),
          ),
        ],
      ),
    );
  }
}
