import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context){
return AppBar(
backgroundColor: Theme.of(context).colorScheme.primary,
title: const Text(
      'Whatsapp',
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  );
}