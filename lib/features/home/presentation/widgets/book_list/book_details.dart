import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/styles.dart';
import '../../../data/models/book_model.dart';

class BookDetails extends StatelessWidget {
  final BookModel book;

  const BookDetails({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book.title,
          style: TextStyles.font13DarkBlueMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.h),

        Text(
          'By ${book.authorNames.join(', ')}',
          style: TextStyles.font13GrayRegular,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.h),

        Text(
          'Languages: ${book.languages.join(', ')}',
          style: TextStyles.font13GrayRegular,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.h),

        Text(
          'Downloads: ${book.downloadCount}',
          style: TextStyles.font13GrayRegular,
        ),
      ],
    );
  }
}
