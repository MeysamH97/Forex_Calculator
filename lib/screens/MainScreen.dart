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
  String? marketSelect;
  var unit;

  var lot = 0.0;
  var risk = 0.0;

  TextEditingController balanceController = TextEditingController();
  TextEditingController stopLossController = TextEditingController();
  TextEditingController riskController = TextEditingController();
  TextEditingController marketPriceController = TextEditingController();

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
          child: SingleChildScrollView(
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
                Column(
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
                                    'Market 5',
                                  ],
                                  onItemSelected: (String value) {
                                    setState(() {
                                      marketSelect = value;
                                      print(marketSelect);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: marketSelect == 'XAU/USD',
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Market Price',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    NumberTextField(
                                        textController: marketPriceController,
                                        width: width / 3,
                                        color: theme!.color!),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
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
                                textController: balanceController,
                                width: width / 3,
                                color: theme!.color!),
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
                                  unit = value;
                                },
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            const Text(
                              'Stop Loss (Pips)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            NumberTextField(
                                textController: stopLossController,
                                width: width / 4,
                                color: theme!.color!),
                          ]),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            const Text(
                              'Risk ( \% )',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            NumberTextField(
                                textController: riskController,
                                width: width / 4,
                                color: theme!.color!),
                          ]),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Calculate();
                                },
                                child: Container(
                                  width: width / 2,
                                  padding: EdgeInsets.all(15),
                                  alignment: AlignmentDirectional.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: theme!.color,
                                  ),
                                  child: Text(
                                    'Calculate Lot',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: risk != 0,
                            child: Row(
                              children: [
                                Text(
                                  'Amount of Risk : ${risk.toStringAsFixed(2)} $unit',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.red[800]),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: lot != 0,
                            child: Row(
                              children: [
                                Text('Lot Volume : ${lot.toStringAsFixed(2)} ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: theme!.color!),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
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

  String Calculate() {
    double? balance = double.tryParse(balanceController.text);
    double? riskPercentage = double.tryParse(riskController.text);
    double? stopLossPoints = double.tryParse(stopLossController.text);
    double pointValue = double.tryParse(marketPriceController.text) != null
        ? double.tryParse(marketPriceController.text)! / 1000
        : 1; // برای مثال مقدار ارزش هر پوینت برای EUR/USD

    if (balance != null && riskPercentage != null && stopLossPoints != null) {
      double riskAmount = balance * (riskPercentage / 100);
      risk = riskAmount;
      double lotSize = riskAmount / (stopLossPoints * pointValue);
      lot = lotSize;
      setState(() {});
      return '';
    } else {
      setState(() {});
      return "Invalid input for balance, risk percentage or stop loss points";
    }
  }
}
