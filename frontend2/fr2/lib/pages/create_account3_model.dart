import 'create_account3_widget.dart' show CreateAccount3Widget;
import 'package:flutter/material.dart';

import 'package:flutterflow_ui/flutterflow_ui.dart';

class CreateAccount3Model extends FlutterFlowModel<CreateAccount3Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for emailAddressField widget.
  FocusNode? emailAddressFieldFocusNode;
  TextEditingController? emailAddressFieldTextController;
  String? Function(BuildContext, String?)?
  emailAddressFieldTextControllerValidator;
  // State field(s) for passwordField widget.
  FocusNode? passwordFieldFocusNode;
  TextEditingController? passwordFieldTextController;
  late bool passwordFieldVisibility;
  String? Function(BuildContext, String?)? passwordFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {
    passwordFieldVisibility = false;
  }

  @override
  void dispose() {
    emailAddressFieldFocusNode?.dispose();
    emailAddressFieldTextController?.dispose();

    passwordFieldFocusNode?.dispose();
    passwordFieldTextController?.dispose();
  }
}
