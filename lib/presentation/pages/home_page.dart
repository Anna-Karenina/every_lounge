import 'package:every_test/presentation/pages/film_list.dart';
import 'package:every_test/presentation/pages/not_found_page.dart';
import 'package:every_test/presentation/pages/search_page.dart';
import 'package:every_test/store/film.dart';
import 'package:every_test/utils/costom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_common/di/di.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final FilmStore _filmStore = DiManager.getFilmStore();

  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const FilmList(),
    const SearchPage()
  ];

  @override
  void initState() {
    _asyncInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      appBar: AppBar(
        title: Text(
          getBottomNavigationBarItems().elementAt(_selectedIndex).label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: getBottomNavigationBarItems(),
        currentIndex: _selectedIndex,
        selectedItemColor: CustomColors.themeBlue,
        unselectedItemColor: CustomColors.themeGray,
        onTap: _onItemTapped,
      ),
    );
  }

  getBottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: AppLocalizations.of(context)!.navigation_title_home,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.search),
        label: AppLocalizations.of(context)!.navigation_title_search,
      ),
    ];
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  void _asyncInit() {
    try {
      _filmStore.getGeneres();
    } catch (e) {
      Navigator.push(
        context,
        MaterialPageRoute<Widget>(
            builder: (BuildContext context) => const NotFoundPage()),
      );
    }
  }
}
