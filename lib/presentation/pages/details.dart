import 'package:every_test/data/models/film.dart';

import 'package:every_test/presentation/components/app_cache_image.dart';
import 'package:every_test/store/film.dart';
import 'package:every_test/utils/costom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:package_common/package_common.dart';

class DescriptionData {
  final IconData icon;
  final String label;
  DescriptionData({required this.icon, required this.label});
}

class DetailsModal extends StatefulWidget {
  final Film film;
  const DetailsModal({super.key, required this.film});

  @override
  State<DetailsModal> createState() => _DetailsModalState();
}

class _DetailsModalState extends State<DetailsModal>
    with SingleTickerProviderStateMixin {
  final FilmStore _filmStore = DiManager.getFilmStore();

  List<DescriptionData> _additionalInfo = [];
  static const List<Tab> _tabs = [Tab(text: "Overview"), Tab(text: "Genre")];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _additionalInfo = _buildDescription();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.film.title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(children: [
          Container(
            height: screenHeight / 3,
            color: Colors.transparent,
            child: Stack(children: [
              SizedBox(
                width: double.infinity,
                height: screenHeight / 4,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                    ),
                    child: AppCacheImage(path: widget.film.backdropPath)),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth / 7),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      SizedBox(
                        height: screenHeight / 7,
                        child: AspectRatio(
                          aspectRatio: 9 / 13,
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child:
                                  AppCacheImage(path: widget.film.posterPath)),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: screenWidth / 1.7,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 38.0, right: 8),
                            child: RichText(
                              text: TextSpan(
                                text: widget.film.title,
                                style: const TextStyle(
                                    color: Color(0xff324074),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: SizedBox(
              height: 18,
              child: ListView.separated(
                itemCount: _additionalInfo.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (BuildContext context, int index) =>
                    const VerticalDivider(
                  thickness: 1,
                  width: 14,
                  color: CustomColors.lightGray,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Icon(
                        _additionalInfo[index].icon,
                        size: 16,
                        color: CustomColors.lightGray,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _additionalInfo[index].label,
                        style: const TextStyle(
                            color: CustomColors.lightGray,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: _tabs,
                  dividerHeight: 0,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    return states.contains(MaterialState.focused)
                        ? null
                        : Colors.transparent;
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    width: screenWidth,
                    height: 200,
                    child: TabBarView(controller: _tabController, children: [
                      _drawOverview(),
                      _drawGenere(),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ]));
  }

  List<DescriptionData> _buildDescription() {
    return [
      DescriptionData(label: widget.film.voteAverage, icon: Icons.stars),
      DescriptionData(
          label: widget.film.releaseYear, icon: Icons.calendar_month),
      DescriptionData(label: widget.film.voteCount, icon: Icons.visibility),
    ];
  }

  _drawOverview() {
    return Text(widget.film.overview);
  }

  _drawGenere() {
    return Observer(builder: (ctx) {
      final filmGeneres =
          _filmStore.generes.where((g) => widget.film.generes.contains(g!.id));
      return Wrap(
          spacing: 10,
          children: filmGeneres
              .map((g) => Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  decoration: BoxDecoration(
                      color: CustomColors.lightGray,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(g!.name)))
              .toList());
    });
  }
}
