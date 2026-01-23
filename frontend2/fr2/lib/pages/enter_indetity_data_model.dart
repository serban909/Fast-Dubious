import 'enter_indetity_data_widget.dart' show EnterIndetityDataWidget;
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class EnterIndetityDataModel extends FlutterFlowModel<EnterIndetityDataWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for FullName widget.
  FocusNode? fullNameFocusNode;
  TextEditingController? fullNameTextController;
  String? Function(BuildContext, String?)? fullNameTextControllerValidator;
  String? _fullNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the patients full name.';
    }

    return null;
  }

  // State field(s) for AgeField widget.
  FocusNode? ageFieldFocusNode;
  TextEditingController? ageFieldTextController;
  String? Function(BuildContext, String?)? ageFieldTextControllerValidator;
  String? _ageFieldTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter an age for the patient.';
    }

    return null;
  }

  // State field(s) for NationalityField widget.
  FocusNode? nationalityFieldFocusNode;
  TextEditingController? nationalityFieldTextController;
  String? Function(BuildContext, String?)?
  nationalityFieldTextControllerValidator;
  // State field(s) for DateOfBirthField widget.
  FocusNode? dateOfBirthFieldFocusNode;
  TextEditingController? dateOfBirthFieldTextController;
  //late MaskTextInputFormatter dateOfBirthFieldMask;
  String? Function(BuildContext, String?)?
  dateOfBirthFieldTextControllerValidator;
  String? _dateOfBirthFieldTextControllerValidator(
    BuildContext context,
    String? val,
  ) {
    if (val == null || val.isEmpty) {
      return 'Please enter the date of birth of the patient.';
    }

    return null;
  }

  // State field(s) for Address widget.
  FocusNode? addressFieldFocusNode;
  TextEditingController? addressFieldTextController;
  String? Function(BuildContext, String?)? addressFieldTextControllerValidator;

  // State field(s) for PlaceOfBirth widget.
  FocusNode? placeOfBirthFieldFocusNode;
  TextEditingController? placeOfBirthFieldTextController;
  String? Function(BuildContext, String?)? placeOfBirthFieldTextControllerValidator;

  // State field(s) for PhotoDescription widget.
  FocusNode? photoDescriptionFocusNode;
  TextEditingController? photoDescriptionTextController;
  String? Function(BuildContext, String?)?
  photoDescriptionTextControllerValidator;
  
  // State field for Randomize Checkbox
  bool shouldRandomize = false;

  @override
  void initState(BuildContext context) {
    fullNameTextControllerValidator = _fullNameTextControllerValidator;
    ageFieldTextControllerValidator = _ageFieldTextControllerValidator;
    dateOfBirthFieldTextControllerValidator =
        _dateOfBirthFieldTextControllerValidator;
  }

  @override
  void dispose() {
    fullNameFocusNode?.dispose();
    fullNameTextController?.dispose();

    ageFieldFocusNode?.dispose();
    ageFieldTextController?.dispose();

    nationalityFieldFocusNode?.dispose();
    nationalityFieldTextController?.dispose();

    dateOfBirthFieldFocusNode?.dispose();
    dateOfBirthFieldTextController?.dispose();

    addressFieldFocusNode?.dispose();
    addressFieldTextController?.dispose();

    placeOfBirthFieldFocusNode?.dispose();
    placeOfBirthFieldTextController?.dispose();

    photoDescriptionFocusNode?.dispose();
    photoDescriptionTextController?.dispose();
  }
}
