import 'package:every_test/data/models/film.dart';
import 'package:every_test/presentation/pages/not_found_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:every_test/presentation/components/film_item.dart';
import 'package:every_test/store/film.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:package_common/package_common.dart';

class FilmList extends StatefulWidget {
  const FilmList({super.key});

  @override
  State<FilmList> createState() => _FilmListState();
}

class _FilmListState extends State<FilmList>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  final FilmStore _filmStore = DiManager.getFilmStore();
  final PagingController<int, Film> _pagingController =
      PagingController(firstPageKey: 1);
  final _pageSize = 20;

  @override
  void initState() {
    _pagingController.addPageRequestListener(_fetchFilms);
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Observer(builder: (context) {
      return _drawList();
    });
  }

  _drawList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8),
          child: Text(AppLocalizations.of(context)!.most_popular,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: PagedListView<int, Film>(
              pagingController: _pagingController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              addAutomaticKeepAlives: true,
              shrinkWrap: false,
              builderDelegate: PagedChildBuilderDelegate<Film>(
                animateTransitions: true,
                itemBuilder: (context, item, index) => FilmItem(item: item),
                noItemsFoundIndicatorBuilder: (context) =>
                    _drawInfo(AppLocalizations.of(context)!.not_found),
                newPageErrorIndicatorBuilder: (context) => _drawInfo(
                    AppLocalizations.of(context)!.searching_most_popular_error),
                firstPageErrorIndicatorBuilder: (context) => _drawInfo(
                    AppLocalizations.of(context)!.searching_most_popular_error),
                firstPageProgressIndicatorBuilder: (context) => _drawInfo(
                    AppLocalizations.of(context)!.searching_most_popular),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _fetchFilms(int pageKey) async {
    try {
      final data = await _filmStore.getFilms(pageKey, _pageSize);
      if (_filmStore.isLastPage) {
        _pagingController.appendLastPage(data);
      } else {
        _pagingController.appendPage(data, pageKey + 1);
      }
    } catch (e) {
      if (pageKey == 1) {
        _goNotFound();
      } else {
        MotionToast.error(
                title: const Text("Error"),
                description: const Text("Fetch error"))
            .show(context);
      }
    }
  }

  void _goNotFound() {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
          builder: (BuildContext context) => const NotFoundPage()),
    );
  }

  Future<void> _onRefresh() async {
    _pagingController.itemList = [];
    await _fetchFilms(1);
  }

  _drawInfo(String text) => Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
}
