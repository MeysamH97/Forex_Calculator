import 'package:flutter/material.dart';
import 'package:forex_calculator/models/theme.dart';
import 'package:forex_calculator/widgets/drop_down_button.dart';
import 'package:forex_calculator/widgets/input_field.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MyTheme? theme;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = themes[0];
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    var marketSelect;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.black,
              theme!.color!,
              theme!.color!.withOpacity(0.75),
              theme!.color!.withOpacity(0.50),
              theme!.color!.withOpacity(0.25),
              theme!.color!.withOpacity(0.0),
              theme!.color!.withOpacity(0.0),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: width,
                    height: 75,
                    child: Image.asset(
                      theme!.headerImage!,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    height: 75,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [theme!.color!, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                      left: 20,
                      top: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: theme!.color!.withOpacity(0.25),
                          child: IconButton(
                            icon: Icon(
                              Icons.color_lens,
                              color: theme!.color!,
                            ),
                            onPressed: () {
                              changeTheme();
                            },
                          ),
                        ),
                      )),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Market',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: CustomDropdownButton(
                                  color: theme!.color!,
                                  items: const [
                                    'XAU/USD',
                                    'EURO/USD',
                                    'Market 3',
                                    'Market 4',
                                    'Market 4',
                                    'Market 4',
                                    'Market 4',
                                    'Market 4',
                                  ],
                                  onItemSelected: (String value) {
                                    marketSelect = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            const Text(
                              'Balance',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            NumberTextField(
                                width: width / 3, color: theme!.color!),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'Unit',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomDropdownButton(
                                color: theme!.color!,
                                items: const [
                                  'Dollar \$',
                                  'EURO \€',
                                  'Rial ',
                                ],
                                onItemSelected: (String value) {
                                  marketSelect = value;
                                },
                              ),
                            ),
                          ]),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeTheme() {
    setState(() {
      if (theme == themes[0]) {
        theme = themes[1];
      } else if (theme == themes[1]) {
        theme = themes[2];
      } else if (theme == themes[2]) {
        theme = themes[0];
      }
    });
  }


}
