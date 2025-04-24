import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/book_model.dart';
import 'book_list/phone_layout.dart';
import 'book_list/phone_landscape_layout.dart';
import 'book_list/tablet_layout.dart';

/// Main book list item widget that adapts to different device types and orientations
class BookListItem extends StatefulWidget {
  final BookModel book;

  const BookListItem({super.key, required this.book});

  @override
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if we're on a tablet or in landscape orientation
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isPhoneLandscape = isLandscape && !isTablet;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 20.r : 16.r),
        child: _buildAdaptiveLayout(isTablet, isLandscape, isPhoneLandscape),
      ),
    );
  }

  /// Builds the appropriate layout based on device and orientation
  Widget _buildAdaptiveLayout(
    bool isTablet,
    bool isLandscape,
    bool isPhoneLandscape,
  ) {
    if (isPhoneLandscape) {
      return PhoneLandscapeLayout(
        book: widget.book,
        isExpanded: _isExpanded,
        onToggleExpand: _toggleExpand,
      );
    } else if (isTablet && !isLandscape) {
      return TabletLayout(
        book: widget.book,
        isExpanded: _isExpanded,
        onToggleExpand: _toggleExpand,
      );
    } else {
      return PhoneLayout(
        book: widget.book,
        isExpanded: _isExpanded,
        onToggleExpand: _toggleExpand,
      );
    }
  }
}
