import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fruitapp/Chart/line_chart_widget.dart';
import 'package:fruitapp/widgets/appbar.dart';

// Statistics(["0","2000","500","300","900"],["0","500","1000","300","900"],["0","1000","500","300","900"],time)

class Statistics extends StatelessWidget {

  List<String> noXValues =[], noYValues=[];
  List<String> mlXValues =[], mlYValues=[];
  List<String> kgXValues =[], kgYValues=[];
  final List<FlSpot> noflSpot = [];
  final List<FlSpot> mlflSpot = [];
  final List<FlSpot> kgflSpot = [];
  String time="00:00:00";

  Statistics(List<String>noYValues,List<String>mlYValues,List<String>kgYValues,String time){

    if(noYValues!=null) {
      for (int i = 0; i < noYValues.length; i++) {
        this.noflSpot.add(
            FlSpot(double.parse(i.toString()), double.parse(noYValues[i])));
        this.mlflSpot.add(
            FlSpot(double.parse(i.toString()), double.parse(mlYValues[i])));
        this.kgflSpot.add(
            FlSpot(double.parse(i.toString()), double.parse(kgYValues[i])));

        this.noYValues = noYValues;
        this.kgYValues = kgYValues;
        this.mlYValues = mlYValues;
        this.time = time;
      }
    }
    else{
      this.noflSpot.add(FlSpot(0, 0));
      this.mlflSpot.add(FlSpot(0,0));
      this.kgflSpot.add(FlSpot(0,0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StandardAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,20,0,0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,0,20),
                      child: Text("No:",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                    )],
                ),
                Row(
                  children: [LineChartWidget(spotList:noflSpot,xValues:noXValues,yValues:noYValues)],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,0,20),
                      child: Text("ML:",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                    )],
                ),
                Row(
                  children: [Center(child: LineChartWidget(spotList:mlflSpot,xValues:mlXValues,yValues:mlYValues))],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,0,20),
                      child: Text("Kg:",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                    )],
                ),
                Row(
                  children: [Center(child: LineChartWidget(spotList:kgflSpot,xValues:kgXValues,yValues:kgYValues))],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,0,0,20),
                      child: Text("Time:",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                    )],
                ),
                Row(
                  children: [Center(child: Text(this.time))])
              ],
            ),
          ),
        ));
  }
}
