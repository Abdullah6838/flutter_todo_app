import 'package:flutter/material.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/todo.dart';
import 'package:todoapp/todoitems.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final todoslist = Todo.todoList();
  final newTodoAdd = TextEditingController();
  List<Todo> foundToDo = [];

  @override
  void initState() {
    foundToDo = todoslist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: appbar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchbox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          'All ToDos', 
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      for(Todo todo in foundToDo.reversed)
                        todoitems(
                          todo: todo,
                          onToDoChange: handleToDo,
                          onDeleteItem: deleteItem,
                        ),
                    ],
                  ),
                ),
              ]
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, bottom: 20, right: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: newTodoAdd,
                      decoration: InputDecoration(
                        hintText: 'Add New ToDo',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    child: Text('+', style: TextStyle(fontSize: 40, color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(side: BorderSide.none),
                      backgroundColor: tdBlue,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                    onPressed: () {
                      addToDoItem(newTodoAdd.text);
                    }
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void handleToDo (Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void deleteItem (String id) {
    setState(() {
      todoslist.removeWhere((item) => item.id == id);
    });
  }

  void addToDoItem (String todo) {
    setState(() {
      todoslist.add(Todo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: todo));
    });
    newTodoAdd.clear();
  }

  void runfilter (String enteredWord) {
    List<Todo> results = [];
    if(enteredWord.isEmpty){
      results = todoslist;
    }
    else {
      results = todoslist.where((item) => item.todoText!.toLowerCase().contains(enteredWord.toLowerCase())).toList();
    }

    setState(() {
      foundToDo = results;
    });
  }

  Widget searchbox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => runfilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGray),
        ),
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, size: 30, color: tdBlack),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset('images/profilepic.png'),
            ),
          ),
        ],
      ),
    );
  }
}
