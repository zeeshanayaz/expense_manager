import 'package:expense_manager/Components/CardList.dart';
import 'package:expense_manager/Components/TransactionView.dart';
import 'package:expense_manager/Model/TransactionModel.dart';
import 'package:expense_manager/Pages/AddCardPage.dart';
import 'package:expense_manager/Providers/CardProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider<CardProvider>(
        create: (_) => CardProvider(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<CardProvider>(context).initialState();

    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 241, 242, 1),
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          "Expense Manager",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromRGBO(238, 241, 242, 1),
        centerTitle: true,
        elevation: 0,
        leading: null,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black45,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddCardPage()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (Provider.of<CardProvider>(context).getCardLength() > 0
                  ? Container(
                      height: 210,
                      child: Consumer<CardProvider>(
                        builder: (context, cards, child) => CardList(
                          cards: cards.allCards,
                        ),
                      )
                      // CardView(CardModel(
                      //     available: 1000,
                      //     currency: 'US',
                      //     name: 'MasterCard',
                      //     number: '1234 **** ***** 4321')),
                      )
                  : Container(
                      height: 210,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Add your new card click the \n + \n button in the top right.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Last Transaction",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.black45,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TransactionView(
                  transaction: TransactionModel(
                      name: 'Shopping',
                      price: 1000,
                      type: "-",
                      currency: 'US')),
              TransactionView(
                  transaction: TransactionModel(
                      name: 'Salary', price: 1000, type: "+", currency: 'US')),
              TransactionView(
                  transaction: TransactionModel(
                      name: 'Receive', price: 1000, type: "+", currency: 'US')),
              TransactionView(
                  transaction: TransactionModel(
                      name: 'Expense ',
                      price: 1000,
                      type: "-",
                      currency: 'US')),
            ],
          ),
        ),
      ),
    );
  }
}
