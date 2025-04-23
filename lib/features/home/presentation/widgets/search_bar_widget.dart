import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final VoidCallback onClear;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 48.h,
      decoration: BoxDecoration(
        color: ColorsManager.moreLighterGray,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorsManager.lighterGray),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search books...',
          hintStyle: TextStyle(color: ColorsManager.gray, fontSize: 14.sp),
          prefixIcon: Icon(Icons.search, color: ColorsManager.gray, size: 20.r),
          suffixIcon:
              controller.text.isNotEmpty
                  ? GestureDetector(
                    onTap: onClear,
                    child: Icon(
                      Icons.close,
                      color: ColorsManager.gray,
                      size: 20.r,
                    ),
                  )
                  : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 16.w,
          ),
        ),
        onSubmitted: onSearch,
        textInputAction: TextInputAction.search,
        onChanged: (value) {
          // Rebuild to show/hide clear button
          (context as Element).markNeedsBuild();
        },
      ),
    );
  }
}
