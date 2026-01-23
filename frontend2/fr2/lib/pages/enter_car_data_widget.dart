import '/flutter_flow/flutter_flow_theme.dart';
import 'package:fr2/services/vehicle_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'enter_car_data_model.dart';
export 'enter_car_data_model.dart';

import 'package:flutterflow_ui/flutterflow_ui.dart';

class EnterCarDataWidget extends StatefulWidget {
  const EnterCarDataWidget({super.key});

  static String routeName = 'EnterCarData';
  static String routePath = '/enterCarData';

  @override
  State<EnterCarDataWidget> createState() => _EnterCarDataWidgetState();
}

class _EnterCarDataWidgetState extends State<EnterCarDataWidget> {
  late EnterCarDataModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnterCarDataModel());

    _model.fullNameTextController ??= TextEditingController();
    _model.fullNameFocusNode ??= FocusNode();
    _model.fullNameFocusNode!.addListener(() => safeSetState(() {}));
    _model.cnpTextController ??= TextEditingController();
    _model.cnpFocusNode ??= FocusNode();
    _model.cnpFocusNode!.addListener(() => safeSetState(() {}));
    _model.adresaTelMailTextController ??= TextEditingController();
    _model.adresaTelMailFocusNode ??= FocusNode();
    _model.adresaTelMailFocusNode!.addListener(() => safeSetState(() {}));
    _model.modelTextController ??= TextEditingController();
    _model.modelFocusNode ??= FocusNode();
    _model.modelFocusNode!.addListener(() => safeSetState(() {}));
    //_model.modelMask = MaskTextInputFormatter(mask: '##/##/####');
    _model.inmatriculareTextController ??= TextEditingController();
    _model.inmatriculareFocusNode ??= FocusNode();
    _model.inmatriculareFocusNode!.addListener(() => safeSetState(() {}));
    // _model.inmatriculareMask = MaskTextInputFormatter(mask: '##/##/####');
    _model.idSerieTextController ??= TextEditingController();
    _model.idSerieFocusNode ??= FocusNode();
    _model.idSerieFocusNode!.addListener(() => safeSetState(() {}));
    // _model.idSerieMask = MaskTextInputFormatter(mask: '##/##/####');
    _model.capacitatePutereTextController ??= TextEditingController();
    _model.capacitatePutereFocusNode ??= FocusNode();
    _model.capacitatePutereFocusNode!.addListener(() => safeSetState(() {}));
    //_model.capacitatePutereMask = MaskTextInputFormatter(mask: '##/##/####');
    _model.nrLocuriTextController ??= TextEditingController();
    _model.nrLocuriFocusNode ??= FocusNode();
    _model.nrLocuriFocusNode!.addListener(() => safeSetState(() {}));
    // _model.nrLocuriMask = MaskTextInputFormatter(mask: '##/##/####');
    _model.masaTotalaTextController ??= TextEditingController();
    _model.masaTotalaFocusNode ??= FocusNode();
    _model.masaTotalaFocusNode!.addListener(() => safeSetState(() {}));
    // _model.masaTotalaMask = MaskTextInputFormatter(mask: '##/##/####');
    _model.masaAutorizataTextController ??= TextEditingController();
    _model.masaAutorizataFocusNode ??= FocusNode();
    _model.masaAutorizataFocusNode!.addListener(() => safeSetState(() {}));
    // _model.masaAutorizataMask = MaskTextInputFormatter(mask: '##/##/####');
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Formular RCA',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: 'Inter Tight',
                  letterSpacing: 0.0,
                  fontWeight: FlutterFlowTheme.of(
                    context,
                  ).headlineMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(
                    context,
                  ).headlineMedium.fontStyle,
                ),
              ),
              Text(
                'Please fill out the form below to continue.',
                style: FlutterFlowTheme.of(context).labelMedium.override(
                  font: "Inter Tight",
                  letterSpacing: 0.0,
                  fontWeight: FlutterFlowTheme.of(
                    context,
                  ).labelMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                ),
              ),
            ].divide(SizedBox(height: 4)),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 8, 12, 8),
              child: FlutterFlowIconButton(
                borderColor: FlutterFlowTheme.of(context).alternate,
                borderRadius: 12,
                borderWidth: 1,
                buttonSize: 40,
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                icon: Icon(
                  Icons.close_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24,
                ),
                onPressed: () async {
                  //context.pushNamed(ChooseInsuranceWidget.routeName);
                },
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Form(
            key: _model.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, -1),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 770),
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                16,
                                12,
                                16,
                                0,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: _model.fullNameTextController,
                                    focusNode: _model.fullNameFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Owner Full Name*',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .override(
                                            font: 'Inter Tight',
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).headlineMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).headlineMedium.fontStyle,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontStyle,
                                          ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: 'Inter Tight',
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).alternate,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primary,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor:
                                          (_model.fullNameFocusNode?.hasFocus ??
                                              false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                            16,
                                            20,
                                            16,
                                            20,
                                          ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          font: 'Inter Tight',
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(
                                            context,
                                          ).headlineMedium.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(
                                            context,
                                          ).headlineMedium.fontStyle,
                                        ),
                                    cursorColor: FlutterFlowTheme.of(
                                      context,
                                    ).primary,
                                    validator: _model
                                        .fullNameTextControllerValidator
                                        .asValidator(context),
                                    inputFormatters: [
                                      if (!isAndroid && !isiOS)
                                        TextInputFormatter.withFunction((
                                          oldValue,
                                          newValue,
                                        ) {
                                          return TextEditingValue(
                                            selection: newValue.selection,
                                            text: newValue.text,
                                          );
                                        }),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _model.cnpTextController,
                                    focusNode: _model.cnpFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'CNP*',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontStyle,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontStyle,
                                          ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: 'Inter Tight',
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).alternate,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primary,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor:
                                          (_model.cnpFocusNode?.hasFocus ??
                                              false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                            16,
                                            20,
                                            16,
                                            20,
                                          ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: 'Inter Tight',
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontStyle,
                                        ),
                                    cursorColor: FlutterFlowTheme.of(
                                      context,
                                    ).primary,
                                    validator: _model.cnpTextControllerValidator
                                        .asValidator(context),
                                    inputFormatters: [
                                      if (!isAndroid && !isiOS)
                                        TextInputFormatter.withFunction((
                                          oldValue,
                                          newValue,
                                        ) {
                                          return TextEditingValue(
                                            selection: newValue.selection,
                                            text: newValue.text,
                                          );
                                        }),
                                    ],
                                  ),
                                  TextFormField(
                                    controller:
                                        _model.adresaTelMailTextController,
                                    focusNode: _model.adresaTelMailFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Adresa/Telefon/Mail',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontStyle,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontStyle,
                                          ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: 'Inter Tight',
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).alternate,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primary,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor:
                                          (_model
                                                  .adresaTelMailFocusNode
                                                  ?.hasFocus ??
                                              false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                            16,
                                            20,
                                            16,
                                            20,
                                          ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: 'Inter Tight',
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontStyle,
                                        ),
                                    cursorColor: FlutterFlowTheme.of(
                                      context,
                                    ).primary,
                                    validator: _model
                                        .adresaTelMailTextControllerValidator
                                        .asValidator(context),
                                    inputFormatters: [
                                      if (!isAndroid && !isiOS)
                                        TextInputFormatter.withFunction((
                                          oldValue,
                                          newValue,
                                        ) {
                                          return TextEditingValue(
                                            selection: newValue.selection,
                                            text: newValue.text,
                                          );
                                        }),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _model.modelTextController,
                                    focusNode: _model.modelFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Model Vehicul*',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontStyle,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontStyle,
                                          ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: 'Inter Tight',
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).alternate,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primary,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor:
                                          (_model.modelFocusNode?.hasFocus ??
                                              false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                            16,
                                            20,
                                            16,
                                            20,
                                          ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: 'Inter Tight',
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontStyle,
                                        ),
                                    cursorColor: FlutterFlowTheme.of(
                                      context,
                                    ).primary,
                                    validator: _model
                                        .modelTextControllerValidator
                                        .asValidator(context),
                                    //inputFormatters: [_model.modelMask],
                                  ),
                                  TextFormField(
                                    controller:
                                        _model.inmatriculareTextController,
                                    focusNode: _model.inmatriculareFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Nr Inmatriculare*',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontStyle,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontStyle,
                                          ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: 'Inter Tight',
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).alternate,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primary,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor:
                                          (_model
                                                  .inmatriculareFocusNode
                                                  ?.hasFocus ??
                                              false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                            16,
                                            20,
                                            16,
                                            20,
                                          ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: 'Inter Tight',
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontStyle,
                                        ),
                                    cursorColor: FlutterFlowTheme.of(
                                      context,
                                    ).primary,
                                    validator: _model
                                        .inmatriculareTextControllerValidator
                                        .asValidator(context),
                                    //inputFormatters: [_model.inmatriculareMask],
                                  ),
                                  TextFormField(
                                    controller: _model.idSerieTextController,
                                    focusNode: _model.idSerieFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Nr Identificare - serie*',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontStyle,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontStyle,
                                          ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: 'Inter Tight',
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).alternate,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primary,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor:
                                          (_model.idSerieFocusNode?.hasFocus ??
                                              false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                            16,
                                            20,
                                            16,
                                            20,
                                          ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: 'Inter Tight',
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontStyle,
                                        ),
                                    cursorColor: FlutterFlowTheme.of(
                                      context,
                                    ).primary,
                                    validator: _model
                                        .idSerieTextControllerValidator
                                        .asValidator(context),
                                    // inputFormatters: [_model.idSerieMask],
                                  ),
                                  TextFormField(
                                    controller:
                                        _model.capacitatePutereTextController,
                                    focusNode: _model.capacitatePutereFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText:
                                          'Capacitate cilindrica/Putere*',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontStyle,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontStyle,
                                          ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: 'Inter Tight',
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).alternate,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primary,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor:
                                          (_model
                                                  .capacitatePutereFocusNode
                                                  ?.hasFocus ??
                                              false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                            16,
                                            20,
                                            16,
                                            20,
                                          ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: 'Inter Tight',
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontStyle,
                                        ),
                                    cursorColor: FlutterFlowTheme.of(
                                      context,
                                    ).primary,
                                    validator: _model
                                        .capacitatePutereTextControllerValidator
                                        .asValidator(context),
                                    inputFormatters: [
                                      // _model.capacitatePutereMask,
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _model.nrLocuriTextController,
                                    focusNode: _model.nrLocuriFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Nr Locuri*',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontStyle,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontStyle,
                                          ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: 'Inter Tight',
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).alternate,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primary,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor:
                                          (_model.nrLocuriFocusNode?.hasFocus ??
                                              false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                            16,
                                            20,
                                            16,
                                            20,
                                          ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: 'Inter Tight',
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontStyle,
                                        ),
                                    cursorColor: FlutterFlowTheme.of(
                                      context,
                                    ).primary,
                                    validator: _model
                                        .nrLocuriTextControllerValidator
                                        .asValidator(context),
                                    // inputFormatters: [_model.nrLocuriMask],
                                  ),
                                  TextFormField(
                                    controller: _model.masaTotalaTextController,
                                    focusNode: _model.masaTotalaFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Masa Totala*',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontStyle,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontStyle,
                                          ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: 'Inter Tight',
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).alternate,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primary,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor:
                                          (_model
                                                  .masaTotalaFocusNode
                                                  ?.hasFocus ??
                                              false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                            16,
                                            20,
                                            16,
                                            20,
                                          ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: 'Inter Tight',
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontStyle,
                                        ),
                                    cursorColor: FlutterFlowTheme.of(
                                      context,
                                    ).primary,
                                    validator: _model
                                        .masaTotalaTextControllerValidator
                                        .asValidator(context),
                                    //  inputFormatters: [_model.masaTotalaMask],
                                  ),
                                  TextFormField(
                                    controller:
                                        _model.masaAutorizataTextController,
                                    focusNode: _model.masaAutorizataFocusNode,
                                    autofocus: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Masa Autorizata*',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelLarge.fontStyle,
                                          ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: 'Inter Tight',
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).labelMedium.fontStyle,
                                          ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: 'Inter Tight',
                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).error,
                                            fontSize: 12,
                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).bodyMedium.fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).alternate,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primary,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      filled: true,
                                      fillColor:
                                          (_model
                                                  .masaAutorizataFocusNode
                                                  ?.hasFocus ??
                                              false)
                                          ? FlutterFlowTheme.of(context).accent1
                                          : FlutterFlowTheme.of(
                                              context,
                                            ).secondaryBackground,
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                            16,
                                            20,
                                            16,
                                            20,
                                          ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: 'Inter Tight',
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontStyle,
                                        ),
                                    cursorColor: FlutterFlowTheme.of(
                                      context,
                                    ).primary,
                                    validator: _model
                                        .masaAutorizataTextControllerValidator
                                        .asValidator(context),
                                    inputFormatters: [
                                      //    _model.masaAutorizataMask,
                                    ],
                                  ),
                                  Text(
                                    'Insurance Provider',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: 'Inter Tight',
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(
                                            context,
                                          ).labelMedium.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(
                                            context,
                                          ).labelMedium.fontStyle,
                                        ),
                                  ),
                                  FlutterFlowDropDown<String>(
                                    controller:
                                        _model.chooseInsuranceProviderValueController ??=
                                            FormFieldController<String>(null),
                                    options: [
                                      'Insurance Provider 1',
                                      'Insurance Provider 2',
                                      'Insurance Provider 3',
                                    ],
                                    onChanged: (val) => safeSetState(
                                      () =>
                                          _model.chooseInsuranceProviderValue =
                                              val,
                                    ),
                                    width: double.infinity,
                                    height: 52,
                                    searchHintTextStyle:
                                        FlutterFlowTheme.of(
                                          context,
                                        ).labelMedium.override(
                                          font: 'Inter Tight',
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(
                                            context,
                                          ).labelMedium.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(
                                            context,
                                          ).labelMedium.fontStyle,
                                        ),
                                    searchTextStyle:
                                        FlutterFlowTheme.of(
                                          context,
                                        ).bodyMedium.override(
                                          font: 'Inter Tight',
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).primary,
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(
                                            context,
                                          ).bodyMedium.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(
                                            context,
                                          ).bodyMedium.fontStyle,
                                        ),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: 'Inter Tight',
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(
                                            context,
                                          ).bodyLarge.fontStyle,
                                        ),
                                    hintText: 'Select one...',
                                    searchHintText: 'Search for an item...',
                                    searchCursorColor: FlutterFlowTheme.of(
                                      context,
                                    ).primary,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: FlutterFlowTheme.of(
                                        context,
                                      ).secondaryText,
                                      size: 24,
                                    ),
                                    fillColor: FlutterFlowTheme.of(
                                      context,
                                    ).secondaryBackground,
                                    elevation: 2,
                                    borderColor: FlutterFlowTheme.of(
                                      context,
                                    ).alternate,
                                    borderWidth: 2,
                                    borderRadius: 12,
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                      12,
                                      4,
                                      8,
                                      4,
                                    ),
                                    hidesUnderline: true,
                                    isOverButton: true,
                                    isSearchable: true,
                                    isMultiSelect: false,
                                  ),
                                ].divide(SizedBox(height: 12)).addToEnd(SizedBox(height: 32)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 770),
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                    child: FFButtonWidget(
                      onPressed: () async {
                        if (_model.formKey.currentState == null ||
                            !_model.formKey.currentState!.validate()) {
                          return;
                        }
                        
                        // Call API
                        final result = await VehicleApi.createVehicle(
                          registrationNumber: _model.inmatriculareTextController.text,
                          makeModel: _model.modelTextController.text,
                          vin: _model.idSerieTextController.text,
                          enginePower: _model.capacitatePutereTextController.text, // e.g. 1390 cm3 / 55 kW
                          seatsMass: "${_model.nrLocuriTextController.text} / ${_model.masaTotalaTextController.text}", // Combining for now to match backend model
                          
                          // Pass explicit owner details if present
                          firstName: _model.fullNameTextController.text.split(' ').first,
                          lastName: _model.fullNameTextController.text.split(' ').length > 1 ? _model.fullNameTextController.text.split(' ').sublist(1).join(' ') : '',
                          cnp: _model.cnpTextController.text,
                          address: _model.adresaTelMailTextController.text,
                        );

                        if (result.success) {
                           ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Vehicle saved successfully!')),
                          );
                          // Maybe go back or clear form
                          Navigator.pop(context);
                        } else {
                           ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${result.error}')),
                          );
                        }
                      },
                      text: 'Submit Form',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 48,
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context).titleSmall
                            .override(
                              font: 'Inter Tight',
                              color: Colors.white,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(
                                context,
                              ).titleSmall.fontWeight,
                              fontStyle: FlutterFlowTheme.of(
                                context,
                              ).titleSmall.fontStyle,
                            ),
                        elevation: 3,
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
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
