import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/styles.dart';
import '../../../data/models/book_model.dart';
import 'cover_image.dart';

/// Specialized layout for phones in landscape mode to prevent overflow
class PhoneLandscapeLayout extends StatelessWidget {
  final BookModel book;
  final bool isExpanded;
  final VoidCallback onToggleExpand;

  const PhoneLandscapeLayout({
    super.key,
    required this.book,
    required this.isExpanded,
    required this.onToggleExpand,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book cover image - smaller for phone landscape
          BookCoverImage(book: book, width: 60.w, height: 90.h),
          SizedBox(width: 10.w),
          // Book details in a constrained container
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title with more constrained max lines
                Text(
                  book.title,
                  style: TextStyles.font13DarkBlueMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                // Authors
                Text(
                  'By ${book.authorNames.join(', ')}',
                  style: TextStyles.font13GrayRegular,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                // Languages
                Text(
                  'Languages: ${book.languages.join(', ')}',
                  style: TextStyles.font13GrayRegular,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                // Download count
                Text(
                  'Downloads: ${book.downloadCount}',
                  style: TextStyles.font13GrayRegular,
                ),

                // Summary section if available (more compact in landscape)
                if (book.summary != null && book.summary!.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  // Summary with expandable functionality - more compact
                  Text(
                    book.summary!,
                    style: TextStyles.font13DarkBlueRegular,
                    maxLines: isExpanded ? 5 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // See more/less button
                  GestureDetector(
                    onTap: onToggleExpand,
                    child: Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        isExpanded ? 'See Less' : 'See More',
                        style: TextStyles.font13BlueSemiBold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
