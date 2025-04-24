import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../cubit/book_cubit.dart';
import '../cubit/book_state.dart';
import '../../../home/presentation/widgets/book_list_item.dart';
import '../../../home/presentation/widgets/search_bar_widget.dart';
import '../../../home/presentation/widgets/shimmer_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _currentSearchQuery = '';

  @override
  void initState() {
    super.initState();
    // Load initial books
    context.read<BookCubit>().getBooks();

    // Setup scroll controller for infinite scrolling
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final bookCubit = context.read<BookCubit>();
      if (_currentSearchQuery.isEmpty) {
        bookCubit.getBooks();
      } else {
        bookCubit.searchBooks(_currentSearchQuery);
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Load more when we're 200 pixels away from the bottom
    return currentScroll >= (maxScroll - 200.h);
  }

  void _onSearch(String query) {
    _currentSearchQuery = query;
    context.read<BookCubit>().searchBooks(query, refresh: true);
  }

  void _onClearSearch() {
    _searchController.clear();
    _currentSearchQuery = '';
    context.read<BookCubit>().resetSearch();
  }

  // ListView for phone view
  Widget _buildListView(List<dynamic> books, bool hasReachedMax) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: books.length + (hasReachedMax ? 0 : 1),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemBuilder: (context, index) {
        if (index >= books.length) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Center(
              child: CircularProgressIndicator(color: ColorsManager.mainBlue),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: BookListItem(book: books[index]),
        );
      },
    );
  }

  // GridView for tablet view
  Widget _buildGridView(
    List<dynamic> books,
    bool hasReachedMax,
    bool isLandscape,
  ) {
    // Determine grid column count based on orientation
    final columnCount = isLandscape ? 2 : 2;

    return GridView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
        childAspectRatio: isLandscape ? 1.5 : 0.7,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemCount: books.length + (hasReachedMax ? 0 : 1),
      itemBuilder: (context, index) {
        if (index >= books.length) {
          return Center(
            child: CircularProgressIndicator(color: ColorsManager.mainBlue),
          );
        }

        return BookListItem(book: books[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine if we're on a tablet based on width
    final isTablet = MediaQuery.of(context).size.width >= 600;
    // Check if we're in landscape orientation
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Book Listing App', style: TextStyles.font24BlueBold),
        // Add adaptable back button padding for iOS
        automaticallyImplyLeading: false,
        centerTitle: Theme.of(context).platform == TargetPlatform.iOS,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: SearchBarWidget(
              controller: _searchController,
              onSearch: _onSearch,
              onClear: _onClearSearch,
            ),
          ),
          Expanded(
            child: BlocBuilder<BookCubit, BookState>(
              builder: (context, state) {
                if (state is Initial) {
                  return const ShimmerLoading();
                } else if (state is Loading) {
                  return const ShimmerLoading();
                } else if (state is Success) {
                  final books = state.books;
                  final hasReachedMax = state.hasReachedMax;
                  final searchQuery = state.searchQuery;
                  if (books.isEmpty) {
                    return Center(
                      child: Text(
                        searchQuery != null && searchQuery.isNotEmpty
                            ? 'No results found for "$searchQuery"'
                            : 'No books available',
                        style: TextStyles.font13DarkBlueMedium,
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      if (searchQuery != null && searchQuery.isNotEmpty) {
                        await context.read<BookCubit>().searchBooks(
                          searchQuery,
                          refresh: true,
                        );
                      } else {
                        await context.read<BookCubit>().getBooks(refresh: true);
                      }
                    },
                    child:
                        isTablet
                            ? _buildGridView(books, hasReachedMax, isLandscape)
                            : _buildListView(books, hasReachedMax),
                  );
                } else if (state is Error) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Something went wrong',
                          style: TextStyles.font13DarkBlueMedium,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          state.message,
                          style: TextStyles.font13GrayRegular,
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () {
                            if (_currentSearchQuery.isNotEmpty) {
                              context.read<BookCubit>().searchBooks(
                                _currentSearchQuery,
                                refresh: true,
                              );
                            } else {
                              context.read<BookCubit>().getBooks(refresh: true);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.mainBlue,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                          ),
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  );
                }

                // Default case, shouldn't reach here
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
