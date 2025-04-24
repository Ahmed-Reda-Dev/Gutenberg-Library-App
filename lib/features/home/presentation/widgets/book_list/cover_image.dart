import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/colors.dart';
import '../../../data/models/book_model.dart';

/// Widget to display the book cover image
class BookCoverImage extends StatelessWidget {
  final BookModel book;
  final double? width;
  final double? height;

  const BookCoverImage({
    super.key,
    required this.book,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 80.w,
      height: height ?? 120.h,
      child:
          book.coverImageUrl != null
              ? ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl: book.coverImageUrl!,
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
}
