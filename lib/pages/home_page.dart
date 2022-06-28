import 'package:coinbase_clone/pages/coin_page.dart';
import 'package:coinbase_clone/services/coin_repository.dart';
import 'package:coinbase_clone/widgets/coin_card.dart';
import 'package:flutter/material.dart';

import '../model/coin.dart';
import '../util/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  late Future<List<Coin>> _getCoins;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCoins = CoinRepository.getCoins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.notifications)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total balance",
                      style: TextStyle(
                          color: Colors.black.withOpacity(.55), fontSize: 15),
                    ),
                    const Text(
                      "\$259.54",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15.0, bottom: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Top assets",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: const [
                        Text(
                          "View all",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                  ],
                ),
              ),
              FutureBuilder<List<Coin>>(
                  future: _getCoins,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null) {
                      final coins = snapshot.data ?? [];
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 40),
                        child: Column(
                          children: coins
                              .map((coin) => GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CoinPage(coin: coin))),
                                  child: CoinCard(coin: coin)))
                              .toList(),
                        ),
                      );
                    }
                    return const Center(child: Text("Loading"));
                  })
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: SizedBox(
          height: 56,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconBottomBar(
                    text: "Assets",
                    icon: Icons.pie_chart_outline,
                    selected: _selectedIndex == 0,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    }),
                IconBottomBar(
                    text: "Trade",
                    icon: Icons.bar_chart,
                    selected: _selectedIndex == 1,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    }),
                IconBottomBar2(
                    text: "Pay",
                    icon: Icons.compare_arrows_sharp,
                    selected: _selectedIndex == 2,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    }),
                IconBottomBar(
                    text: "Pay",
                    icon: Icons.circle_outlined,
                    selected: _selectedIndex == 3,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                    }),
                IconBottomBar(
                    text: "For You",
                    icon: Icons.dashboard_outlined,
                    selected: _selectedIndex == 3,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon,
              size: 25,
              color: selected
                  ? CoinbaseTheme.color
                  : Colors.black.withOpacity(.75)),
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 12,
              height: .1,
              color: selected
                  ? CoinbaseTheme.color
                  : Colors.black.withOpacity(.75)),
        )
      ],
    );
  }
}

class IconBottomBar2 extends StatelessWidget {
  const IconBottomBar2(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: CoinbaseTheme.color,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 25,
          color: selected ? CoinbaseTheme.color : Colors.white,
        ),
      ),
    );
  }
}
