import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();


  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('usuarios').add({
          'nombre': _nombreController.text,
         
        });

        _nombreController.clear();

        

        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Datos guardados exitosamente')),
        );
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al guardar los datos')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Recuérdame....ingleChildScrollView
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 32),
                const Text(
                  'Crear nuevo profesor',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese el nombre';
                    }
                    return null;
                  },
                ),
               
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _submitForm(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('REGISTRAR'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
