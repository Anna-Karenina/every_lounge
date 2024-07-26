import 'package:every_test/data/mappers/dto_to_film.dart';
import 'package:every_test/data/models/film.dart';
import 'package:every_test/presentation/components/film_item.dart';
import 'package:every_test/presentation/components/search_input_silver.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:package_common/di/di.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final PagingController<int, Film> _pagingController =
      PagingController(firstPageKey: 1);

  final repository = DiManager.getTheMoveDbRepository();
  final _pageSize = 20;
  String query = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: <Widget>[
          SearchInputSliver(
            debounceTime: const Duration(milliseconds: 400),
            onChanged: _onSearchChange,
          ),
          PagedSliverList<int, Film>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Film>(
              firstPageProgressIndicatorBuilder: (context) => Container(),
              noItemsFoundIndicatorBuilder: (context) =>
                  Center(child: Text(AppLocalizations.of(context)!.not_found)),
              itemBuilder: (context, item, index) => FilmItem(
                item: item,
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> _onSearchChange(String value) async {
    try {
      setState(() => query = value);
      _pagingController.removePageRequestListener(_fetchFilms);
      _pagingController.itemList = [];

      final apiList = await repository.searchFilms(query, 1, _pageSize);
      final currentPortition = apiList.map(fromDtoToFilm).toList();
      final isLastPage = apiList.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(currentPortition);
      } else {
        _pagingController.appendPage(currentPortition, 2);
        _pagingController.addPageRequestListener(_fetchFilms);
      }
    } catch (e) {}
  }

  Future<void> _fetchFilms(int pageKey) async {
    final apiList = await repository.searchFilms(
        query, _pagingController.nextPageKey ?? 1, _pageSize);

    final isLastPage = apiList.length < _pageSize;
    final currentPortition = apiList.map(fromDtoToFilm).toList();

    if (isLastPage) {
      _pagingController.appendLastPage(currentPortition);
    } else {
      _pagingController.appendPage(currentPortition, pageKey + 1);
    }
  }
}
