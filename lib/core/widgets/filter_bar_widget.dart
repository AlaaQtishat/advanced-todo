// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todo/core/constants/app_themes.dart';
// import 'package:todo/core/providers/theme_provider.dart';
// import 'package:todo/core/widgets/customized_elevated_button.dart';
//
// class FilterBarWidget extends StatelessWidget {
//   final String currentFilter;
//   final Function(String)
//   onFilterChanged; //don't forget it is same as final ValueChanged<String> onFilterChanged;
//
//   const FilterBarWidget({
//     required this.currentFilter,
//     required this.onFilterChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       height: 80,
//       width: double.infinity,
//       child: Row(
//         children: [
//           Expanded(
//             child: CustomizedElevatedButton(
//               onPressed: () {
//                 onFilterChanged("All");
//               },
//               text: "All",
//             //  gradient: currentFilter == "All" ? AppThemes.gradient : null,
//               color: currentFilter == "All"
//                   ? null
//                   : (isDark ? const Color(0xFF171717) : Colors.grey[100]),
//               textColor: currentFilter == "All"
//                   ? Colors.white
//                   : (isDark ? Colors.white : Colors.black87),
//             ),
//           ),
//           const SizedBox(width: 8),
//
//           Expanded(
//             child: CustomizedElevatedButton(
//               onPressed: () {
//                 onFilterChanged("Active");
//               },
//               text: "Active",
//             //  gradient: currentFilter == "Active" ? AppThemes.gradient : null,
//               color: currentFilter == "Active"
//                   ? null
//                   : (isDark ? const Color(0xFF171717) : Colors.grey[100]),
//               textColor: currentFilter == "Active"
//                   ? Colors.white
//                   : (isDark ? Colors.white : Colors.black87),
//             ),
//           ),
//           const SizedBox(width: 8),
//
//           Expanded(
//             child: CustomizedElevatedButton(
//               onPressed: () {
//                 onFilterChanged("Completed");
//               },
//               text: "Completed",
//             //  gradient: currentFilter == "Completed"
//                   ? AppThemes.gradient
//                   : null,
//               color: currentFilter == "Completed"
//                   ? null
//                   : (isDark ? const Color(0xFF171717) : Colors.grey[100]),
//               textColor: currentFilter == "Completed"
//                   ? Colors.white
//                   : (isDark ? Colors.white : Colors.black87),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
