import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../home/data/models/book_model.dart';

class BookListItem extends StatefulWidget {
  final BookModel book;

  const BookListItem({super.key, required this.book});

  @override
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book cover image
                _buildCoverImage(),
                SizedBox(width: 16.w),
                // Book details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        widget.book.title,
                        style: TextStyles.font13DarkBlueMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      // Authors
                      Text(
                        'By ${widget.book.authorNames.join(', ')}',
                        style: TextStyles.font13GrayRegular,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      // Languages
                      Text(
                        'Languages: ${widget.book.languages.join(', ')}',
                        style: TextStyles.font13GrayRegular,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      // Download count
                      Text(
                        'Downloads: ${widget.book.downloadCount}',
                        style: TextStyles.font13GrayRegular,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Summary section if available
            if (widget.book.summary != null &&
                widget.book.summary!.isNotEmpty) ...[
              SizedBox(height: 16.h),
              // Summary title
              Text('Summary', style: TextStyles.font13BlueSemiBold),
              SizedBox(height: 8.h),
              // Summary with expandable functionality
              _buildExpandableSummary(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImage() {
    return SizedBox(
      width: 80.w,
      height: 120.h,
      child:
          widget.book.coverImageUrl != null
              ? ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl: widget.book.coverImageUrl!,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Container(
                        color: ColorsManager.lighterGray,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: ColorsManager.mainBlue,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                  errorWidget:
                      (context, url, error) => Container(
                        color: ColorsManager.lighterGray,
                        child: const Icon(
                          Icons.book,
                          color: ColorsManager.gray,
                        ),
                      ),
                ),
              )
              : Container(
                decoration: BoxDecoration(
                  color: ColorsManager.lighterGray,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: const Center(
                  child: Icon(Icons.book, color: ColorsManager.gray),
                ),
              ),
    );
  }

  Widget _buildExpandableSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.book.summary!,
          style: TextStyles.font13DarkBlueRegular,
          maxLines: _isExpanded ? null : 3,
          overflow: _isExpanded ? null : TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? 'See Less' : 'See More',
            style: TextStyles.font13BlueSemiBold,
          ),
        ),
      ],
    );
  }
}
