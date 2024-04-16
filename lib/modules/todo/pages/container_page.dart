import 'package:flutter/material.dart';
import 'package:todo_moura/modules/todo/pages/to_do_page.dart';

class ContainerPage extends StatefulWidget {
  const ContainerPage({super.key});

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  List<Widget> pages =  [
    ToDoPage(key: UniqueKey(),done: false),
    ToDoPage(key: UniqueKey(),done: true),
  ];

  

  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: (index) {
            pageIndex = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                ),
                label: "A fazer"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                ),
                label: "Feito")
          ]),
      body: pages[pageIndex],
    );
  }
}
