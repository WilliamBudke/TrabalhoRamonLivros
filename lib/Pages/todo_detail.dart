import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_flutter/Models/todo.dart';
import 'package:todo_list_flutter/Utils/database_helper.dart';


class TodoDetail extends StatefulWidget {
  final String appBarTitle;
  final Todo todo;

  TodoDetail(this.todo, this.appBarTitle);
  @override
  _TodoDetailState createState() {
    return _TodoDetailState(this.todo, this.appBarTitle);
  }
}

class _TodoDetailState extends State<TodoDetail> {
  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Todo todo;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController autorController = TextEditingController();
  TextEditingController editoraController = TextEditingController();

  _TodoDetailState(this.todo, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    titleController.text = todo.title;
    descriptionController.text = todo.desc;
    autorController.text = todo.autor;
    editoraController.text = todo.editora;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              moveToLastScreen();
            }),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('campo1');
                  updateTitle();
                },
                decoration: InputDecoration(
                    labelText: 'Titulo',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            // 3 elemento
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: autorController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('campo3');
                  updateAutor();
                },
                decoration: InputDecoration(
                    labelText: 'Autor',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: editoraController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('campo4');
                  updateEditora();
                },
                decoration: InputDecoration(
                    labelText: 'Editora',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),

            // quart Elemento
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Salvar',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint("Clicou em salvar");
                          _save();
                        });
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Apagar',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint("clicou em apagar");
                          _delete();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateTitle() {
    todo.title = titleController.text;
  }

  void updateDescription() {
    todo.description = descriptionController.text;
  }
  void updateAutor() {
    todo.autor = autorController.text;
  }
  void updateEditora() {
    todo.editora = editoraController.text;
  }

  void _save() async {
    moveToLastScreen();

    todo.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (todo.id != null) {
      // Caso 1: Atualizar
      result = await helper.updateTodo(todo);
    } else {
      // Caso 2: Inserir
      result = await helper.insertTodo(todo);
    }

    if (result != 0) {
      // Succeso
      _showAlertDialog('Status', 'Salvo com sucesso $result');
    } else {
      // deu merda
      _showAlertDialog('Status', 'Eita n??is');
    }
  }

  void _delete() async {
    moveToLastScreen();

    if (todo.id == null) {
      _showAlertDialog('Status', 'N??o h?? nada a deletar');
      return;
    }
    int result;
    result = await helper.deleteTodo(todo.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Menos uma coisa a fazer!');
    } else {
      _showAlertDialog('Status', 'Deu pau!');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}