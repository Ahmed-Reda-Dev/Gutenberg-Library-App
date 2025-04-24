import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/styles.dart';
import '../../../data/models/book_model.dart';
import 'book_details.dart';
import 'cover_image.dart';
import 'expandable_summary.dart';

/// Layout specifically optimized for tablet portrait view
class TabletLayout extends StatelessWidget {
  final BookModel book;
  final bool isExpanded;
  final VoidCallback onToggleExpand;

  const TabletLayout({
    super.key,
    required this.book,
    required this.isExpanded,
    required this.onToggleExpand,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Book cover image - centered and larger for tablets
          SizedBox(
            height: 160.h,
            child: Center(
              child: BookCoverImage(book: book, width: 120.w, height: 160.h),
            ),
          ),
          SizedBox(height: 16.h),
          // Book details
          BookDetails(book: book),

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
