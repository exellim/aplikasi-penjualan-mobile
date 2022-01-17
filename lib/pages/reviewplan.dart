import 'package:flutter/material.dart';
import 'package:salessystem/materials/sidebar.dart';

class ReviewPlan extends StatefulWidget {
  ReviewPlan({Key key}) : super(key: key);

  @override
  _ReviewPlanState createState() => _ReviewPlanState();
}

class _ReviewPlanState extends State<ReviewPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review Plan"),
      ),
      drawer: SideBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: Text("Review Plan")),
            ],
          ),
        ),
      ),
    );
  }
}
