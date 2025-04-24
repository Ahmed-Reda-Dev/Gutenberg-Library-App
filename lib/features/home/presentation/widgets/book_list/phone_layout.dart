import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/styles.dart';
import '../../../data/models/book_model.dart';
import 'book_details.dart';
import 'cover_image.dart';
import 'expandable_summary.dart';

/// Layout specifically for phones in portrait mode
class PhoneLayout extends StatelessWidget {
  final BookModel book;
  final bool isExpanded;
  final VoidCallback onToggleExpand;

  const PhoneLayout({
    super.key,
    required this.book,
    required this.isExpanded,
    required this.onToggleExpand,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book cover image
              BookCoverImage(book: book),
              SizedBox(width: 16.w),
              // Book details
              Expanded(child: BookDetails(book: book)),
            ],
          ),

          // Summary section if available
          if (book.summary != null && book.summary!.isNotEmpty) ...[
            SizedBox(height: 16.h),
            // Summary title
            Text('Summary', style: TextStyles.font13BlueSemiBold),
            SizedBox(height: 8.h),
            // Summary with expandable functionality
            ExpandableSummary(
              summary: book.summary!,
              isExpanded: isExpanded,
              onToggleExpand: onToggleExpand,
            ),
          ],
        ],
      ),
    );
  }
}
