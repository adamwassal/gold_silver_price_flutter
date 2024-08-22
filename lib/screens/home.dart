import 'package:flutter/material.dart';
import 'package:today_price/network/dio_helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGoldPrice();
    getSilverPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'TODAY ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('PRICE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      fontSize: 15)),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(onPressed: (){getGoldPrice(); getSilverPrice();},icon: Icon(Icons.refresh),),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/gold.png',
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width / 2.5,
                ),
                Text(
                  'Gold',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: MediaQuery.of(context).size.width / 8,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      BoxShadow(
                          color: Colors.yellow,
                          offset: Offset(2, 2),
                          blurRadius: 5)
                    ],
                  ),
                ),
                Text(
                  goldI != null ? '$goldI EGP' : 'Loading',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: MediaQuery.of(context).size.width / 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  'assets/silver.png',
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width / 2.5,
                ),
                Text(
                  'Silver',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width / 8,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          offset: Offset(2, 2),
                          blurRadius: 5)
                    ],
                  ),
                ),
                Text(
                  silverI !=null ? '${silverI} EGP':'Loading',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width / 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  double? goldD;
  int? goldI;
  double? silverD;
  int? silverI;

  getGoldPrice() {
    goldI = null;
    DioHelper.getData('/XAU/EGP/').then((value) {
      setState(() {
        goldD = value.data['price'];
        goldI = goldD!.round();
        print(goldI);
      });
    }).catchError((error) {
      print(error.toString());
    });
  }

  getSilverPrice() {
    silverI = null;
    DioHelper.getData('/XAG/EGP/').then((value) {
      setState(() {
        silverD = value.data['price'];
        silverI = silverD!.round();
        print(silverI);
      });
    }).catchError((error) {
      print(error.toString());
    });
  }
}
