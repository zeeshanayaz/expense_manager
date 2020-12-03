import 'package:expense_manager/Model/TransactionModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionView extends StatefulWidget {
  final TransactionModel transaction;

  const TransactionView({Key key, this.transaction}) : super(key: key);

  @override
  _TransactionViewState createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.transaction.type == "-"
                  ? Icon(
                      Icons.arrow_upward,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.arrow_downward,
                      color: Colors.green,
                    ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                widget.transaction.name,
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.transaction.type + widget.transaction.price.toString(),
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              Text(
                " " + widget.transaction.currency,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
