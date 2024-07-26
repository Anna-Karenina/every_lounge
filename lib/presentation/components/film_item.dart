import 'package:every_test/data/models/film.dart';
import 'package:every_test/presentation/components/app_cache_image.dart';
import 'package:every_test/presentation/pages/details.dart';
import 'package:every_test/utils/costom_colors.dart';
import 'package:flutter/material.dart';

class FilmItem extends StatelessWidget {
  final Film item;
  const FilmItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final itemHeight = MediaQuery.of(context).size.height / 4.3;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          splashColor: CustomColors.themeBlue,
          borderRadius: BorderRadius.circular(10),
          onTap: () => _showDetails(context, item),
          child: Container(
              height: itemHeight,
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: LayoutBuilder(builder: (context, constraints) {
                      return SizedBox(
                        height: itemHeight,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          child: AppCacheImage(
                            path: item.posterPath,
                          ),
                        ),
                      );
                    }),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                              child: Text(
                            item.title,
                            style: const TextStyle(
                                color: Color(0xff324074),
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          )),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.stars,
                                    size: 16,
                                    color: Color(0xffbfbfbf),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    item.voteAverage,
                                    style: const TextStyle(
                                        color: Color(0xffbfbfbf),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month,
                                      size: 16, color: Color(0xffbfbfbf)),
                                  const SizedBox(width: 6),
                                  Text(item.releaseYear,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: Color(0xffbfbfbf),
                                          fontWeight: FontWeight.w400))
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  _showDetails(
    BuildContext context,
    Film item,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
          builder: (BuildContext context) => DetailsModal(
                film: item,
              )),
    );
  }
}
