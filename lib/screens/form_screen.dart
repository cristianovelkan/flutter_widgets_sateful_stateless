import 'package:flutter/material.dart';
import 'package:flutter_wdgets_sateful_stateless/data/task_inherited.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key, required this.taskContext}) : super(key: key);

  final BuildContext taskContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  bool difficultyValidator(String? value) {
    if (value != null && value.isEmpty) {
      if (int.parse(value) > 5 || int.parse(value) < 1) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nova Tarefa'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
                height: 650,
                width: 375,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 3, color: Colors.black26)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Descrição da Tarefa',
                            fillColor: Colors.white70,
                            filled: true
                        ),
                        validator: (String? value) {
                          if (valueValidator(value)) {
                            return 'Por favor, insira uma descrição';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: difficultyController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Dificuldade',
                            fillColor: Colors.white70,
                            filled: true),
                        validator: (value) {
                          if (difficultyValidator(value)) {
                            return 'Por favor, insira uma dificuldade';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.url,
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: imageController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Imagem',
                            fillColor: Colors.white70,
                            filled: true
                        ),
                        validator: (value) {
                          if (valueValidator(value)) {
                            return 'Por favor, insira uma imagem';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromRGBO(247, 247, 247, 1),
                          border: Border.all(width: 3, color: Colors.black26)),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          imageController.text,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset(
                                'assets/images/no-photo-available.png');
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // print(nameController.text);
                            // print(int.parse(difficultyController.text));
                            // print(imageController.text);
                            TaskInherited.of(widget.taskContext).newTask(
                              nameController.text,
                              imageController.text,
                              int.parse(difficultyController.text)
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text(
                                    'Adicionando Nova Tarefa...'))
                            );
                          }
                          Navigator.pop(context);
                        },
                        child: const Text('Salvar'))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
