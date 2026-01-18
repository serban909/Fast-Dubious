import '/flutter_flow/flutter_flow_theme.dart';
import 'dart:ui';
import 'enter_car_data_widget.dart' show EnterCarDataWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:flutterflow_ui/flutterflow_ui.dart';
import '/flutter_flow/flutter_flow_theme.dart';

class EnterCarDataModel extends FlutterFlowModel<EnterCarDataWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for fullName widget.
  FocusNode? fullNameFocusNode;
  TextEditingController? fullNameTextController;
  String? Function(BuildContext, String?)? fullNameTextControllerValidator;
  String? _fullNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the patients full name.';
    }

    return null;
  }

  // State field(s) for CNP widget.
  FocusNode? cnpFocusNode;
  TextEditingController? cnpTextController;
  String? Function(BuildContext, String?)? cnpTextControllerValidator;
  String? _cnpTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter an age for the patient.';
    }

    return null;
  }

  // State field(s) for adresa_tel_mail widget.
  FocusNode? adresaTelMailFocusNode;
  TextEditingController? adresaTelMailTextController;
  String? Function(BuildContext, String?)? adresaTelMailTextControllerValidator;
  // State field(s) for model widget.
  FocusNode? modelFocusNode;
  TextEditingController? modelTextController;
  //late MaskTextInputFormatter modelMask;
  String? Function(BuildContext, String?)? modelTextControllerValidator;
  String? _modelTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the date of birth of the patient.';
    }

    return null;
  }

  // State field(s) for inmatriculare widget.
  FocusNode? inmatriculareFocusNode;
  TextEditingController? inmatriculareTextController;
  //late MaskTextInputFormatter inmatriculareMask;
  String? Function(BuildContext, String?)? inmatriculareTextControllerValidator;
  // State field(s) for id_serie widget.
  FocusNode? idSerieFocusNode;
  TextEditingController? idSerieTextController;
  //late MaskTextInputFormatter idSerieMask;
  String? Function(BuildContext, String?)? idSerieTextControllerValidator;
  // State field(s) for capacitate_putere widget.
  FocusNode? capacitatePutereFocusNode;
  TextEditingController? capacitatePutereTextController;
  //late MaskTextInputFormatter capacitatePutereMask;
  String? Function(BuildContext, String?)?
  capacitatePutereTextControllerValidator;
  // State field(s) for nr_locuri widget.
  FocusNode? nrLocuriFocusNode;
  TextEditingController? nrLocuriTextController;
  //late MaskTextInputFormatter nrLocuriMask;
  String? Function(BuildContext, String?)? nrLocuriTextControllerValidator;
  // State field(s) for masa_totala widget.
  FocusNode? masaTotalaFocusNode;
  TextEditingController? masaTotalaTextController;
  //late MaskTextInputFormatter masaTotalaMask;
  String? Function(BuildContext, String?)? masaTotalaTextControllerValidator;
  // State field(s) for masa_autorizata widget.
  FocusNode? masaAutorizataFocusNode;
  TextEditingController? masaAutorizataTextController;
  //late MaskTextInputFormatter masaAutorizataMask;
  String? Function(BuildContext, String?)?
  masaAutorizataTextControllerValidator;
  // State field(s) for ChooseInsuranceProvider widget.
  String? chooseInsuranceProviderValue;
  FormFieldController<String>? chooseInsuranceProviderValueController;

  @override
  void initState(BuildContext context) {
    fullNameTextControllerValidator = _fullNameTextControllerValidator;
    cnpTextControllerValidator = _cnpTextControllerValidator;
    modelTextControllerValidator = _modelTextControllerValidator;
  }

  @override
  void dispose() {
    fullNameFocusNode?.dispose();
    fullNameTextController?.dispose();

    cnpFocusNode?.dispose();
    cnpTextController?.dispose();

    adresaTelMailFocusNode?.dispose();
    adresaTelMailTextController?.dispose();

    modelFocusNode?.dispose();
    modelTextController?.dispose();

    inmatriculareFocusNode?.dispose();
    inmatriculareTextController?.dispose();

    idSerieFocusNode?.dispose();
    idSerieTextController?.dispose();

    capacitatePutereFocusNode?.dispose();
    capacitatePutereTextController?.dispose();

    nrLocuriFocusNode?.dispose();
    nrLocuriTextController?.dispose();

    masaTotalaFocusNode?.dispose();
    masaTotalaTextController?.dispose();

    masaAutorizataFocusNode?.dispose();
    masaAutorizataTextController?.dispose();
  }
}
