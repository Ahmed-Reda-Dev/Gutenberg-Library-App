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
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return Container(
      height: isTablet ? 56.h : 48.h,
      decoration: BoxDecoration(
        color: ColorsManager.moreLighterGray,
        borderRadius: BorderRadius.circular(isTablet ? 12.r : 8.r),
        border: Border.all(color: ColorsManager.lighterGray),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search books...',
          hintStyle: TextStyle(
            color: ColorsManager.gray,
            fontSize: isTablet ? 16.sp : 14.sp,
          ),
          prefixIcon: Icon(
            isIOS ? Icons.search : Icons.search,
            color: ColorsManager.gray,
            size: isTablet ? 24.r : 20.r,
          ),
          suffixIcon:
              controller.text.isNotEmpty
                  ? GestureDetector(
                    onTap: onClear,
                    child: Icon(
                      isIOS ? Icons.clear : Icons.close,
                      color: ColorsManager.gray,
                      size: isTablet ? 24.r : 20.r,
                    ),
                  )
                  : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: isTablet ? 16.h : 12.h,
            horizontal: isTablet ? 20.w : 16.w,
          ),
        ),
        onSubmitted: onSearch,
        textInputAction: TextInputAction.search,
        style: TextStyle(fontSize: isTablet ? 16.sp : 14.sp),
        onChanged: (value) {
          (context as Element).markNeedsBuild();
        },
      ),
    );
  }
}
