import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/styles.dart';
import '../../../data/models/book_model.dart';
import 'book_details.dart';
import 'cover_image.dart';
import 'expandable_summary.dart';

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
          SizedBox(
            height: 160.h,
            child: Center(
              child: BookCoverImage(book: book, width: 120.w, height: 160.h),
            ),
          ),
          SizedBox(height: 16.h),

          BookDetails(book: book),

          if (book.summary != null && book.summary!.isNotEmpty) ...[
            SizedBox(height: 16.h),

            Text('Summary', style: TextStyles.font13BlueSemiBold),
            SizedBox(height: 8.h),

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
