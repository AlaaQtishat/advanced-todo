import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/widgets/state_filter_tab.dart';
import 'package:todo/core/widgets/type_filter_tab.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF8FAFC),
        body: Column(
          children: [
            Container(
              height: 250.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Tasks",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),
                            Text(
                              "Sun,July 19",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Color(0xFFF1F5F9),
                              ),
                              icon: Icon(
                                Icons.wb_sunny_outlined,
                                size: 28.sp,
                                color: Color(0xFF62748E),
                              ),
                              onPressed: () {},
                            ),
                            SizedBox(width: 8.w),
                            IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Color(0xFFF1F5F9),
                              ),
                              icon: Icon(
                                Icons.check_box_outlined,
                                size: 28.sp,
                                color: Color(0xFF62748E),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 16.h,
                    ),
                    child: StateFilterTab(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 16.h,
                    ),
                    child: TypeFilterTab(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
