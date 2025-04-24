import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/styles.dart';
import '../../../data/models/book_model.dart';
import 'book_details.dart';
import 'cover_image.dart';
import 'expandable_summary.dart';


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
              
              BookCoverImage(book: book),
              SizedBox(width: 16.w),
              
              Expanded(child: BookDetails(book: book)),
            ],
          ),

          
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
