import 'package:flutter/material.dart';
import 'package:fruitapp/models/day_model.dart';
import 'package:fruitapp/widgets/appbar.dart';
import 'package:provider/provider.dart';

class DayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(),
      body: Consumer<DayModel>(
        builder: (_, data, __) {
          return PageView.builder(
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(top: 10),
                  color: index % 2 == 0 ? Colors.pink : Colors.cyan,
                  child: ListView.builder(itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                      child: Card(
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: 50,
                                height: 150,
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: Container(
                                child: SizedBox(
                                  width: 100,
                                  height: 150,
                                ),
                              ),
                              flex: 4,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 55,
                                height: 150,
                              ),
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              },
              onPageChanged:
                  Provider.of<DayModel>(context, listen: false).pageChanged,
              controller: PageController(initialPage: data.currentIndex));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () {
          // TODO: Implement FAB.
          print("EHUEUEUE");
        },
      ),
    );
  }
}
