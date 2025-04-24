import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/styles.dart';
import '../../../data/models/book_model.dart';
import 'cover_image.dart';

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
          BookCoverImage(book: book, width: 60.w, height: 90.h),
          SizedBox(width: 10.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  book.title,
                  style: TextStyles.font13DarkBlueMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),

                Text(
                  'By ${book.authorNames.join(', ')}',
                  style: TextStyles.font13GrayRegular,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),

                Text(
                  'Languages: ${book.languages.join(', ')}',
                  style: TextStyles.font13GrayRegular,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),

                Text(
                  'Downloads: ${book.downloadCount}',
                  style: TextStyles.font13GrayRegular,
                ),

                if (book.summary != null && book.summary!.isNotEmpty) ...[
                  SizedBox(height: 8.h),

                  Text(
                    book.summary!,
                    style: TextStyles.font13DarkBlueRegular,
                    maxLines: isExpanded ? 5 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),

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
