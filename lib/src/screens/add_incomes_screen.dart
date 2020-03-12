import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meAccounting/src/blocs/incomes_bloc.dart';
import 'package:meAccounting/src/models/income_model.dart';

class AddIncomeScreen extends StatelessWidget {
  /*
   * Class to hold add incomes screen elements
   * 
   */

  // create an instance of incomes bloc in order to access to streams
  final bloc = IncomesBloc();
