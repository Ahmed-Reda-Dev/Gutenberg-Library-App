import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/styles.dart';

/// Widget to display an expandable summary text with "See More"/"See Less" functionality
class ExpandableSummary extends StatelessWidget {
  final String summary;
  final bool isExpanded;
  final VoidCallback onToggleExpand;

  const ExpandableSummary({
    super.key,
    required this.summary,
    required this.isExpanded,
    required this.onToggleExpand,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          summary,
          style: TextStyles.font13DarkBlueRegular,
          maxLines: isExpanded ? null : 3,
          overflow: isExpanded ? null : TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onToggleExpand,
          child: Text(
            isExpanded ? 'See Less' : 'See More',
            style: TextStyles.font13BlueSemiBold,
          ),
        ),
      ],
    );
  }
}
