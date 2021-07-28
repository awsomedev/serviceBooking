import 'package:flutter/material.dart';
import 'package:qask/complaintModel.dart';

class ResultScreen extends StatefulWidget {
  Complaint data;
  ResultScreen({this.data});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.service),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Row(
                children: [
                  Text(
                    'Status :  ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    child: Text(
                      widget.data.complaintStatus.toUpperCase(),
                      style: TextStyle(fontSize: 12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.orange[200]),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Question :',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 15),
              Text(
                widget.data.query,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 20),
              Text(
                'Response :',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 15),
              Text(
                widget.data.solution ?? '',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
