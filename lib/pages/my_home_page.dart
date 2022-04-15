import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/model/characters.dart';
import 'package:rick_and_morty_app/providers/search_delegate.dart';
import 'package:rick_and_morty_app/providers/theme_change.dart';
import 'package:rick_and_morty_app/providers/theme_change_controllers.dart';
import 'package:rick_and_morty_app/widgets/fab_widgets.dart';

class MyHomePage extends StatefulWidget {
  static const id = 'HomeView';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  SwitchThemeApp? _themeController;

  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: FoundHero(),
      query: "any query",
    );
  }

  @override
  Widget build(BuildContext context) {
    List<CharacterAll>? characterAll =
        Provider.of<List<CharacterAll>?>(context);

    var changeTheme = Provider.of<SwitchThemeApp>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lime,
          shadowColor: Colors.indigo,
          actions: [
            IconButton(onPressed: _showSearch, icon: Icon(Icons.search)),
            Radio(
                value: ThemeOption.dark,
                onChanged: (String? select){
                  setState(() {
                    changeTheme.setTheme(select!);
                  });

            }, groupValue: _themeController?.currentTheme,),
            Radio(
              value: ThemeOption.light,
              onChanged: (String? select){
                setState(() {
                  changeTheme.setTheme(select!);
                });

              }, groupValue: _themeController?.currentTheme,)
          ],
        ),
        body: ListView.builder(
            itemCount: characterAll?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: SizedBox(
                  width: 100,
                  height: 70,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          characterAll![index].name!,
                          style: TextStyle(fontSize: 18),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ))
                      ],
                    ),
                    shadowColor: Colors.indigo,
                  ),
                ),
              );
            }
            ),
      floatingActionButton: FABNav(),
    );
  }
}
