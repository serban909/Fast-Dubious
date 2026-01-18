import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import 'display_passport_model.dart';
export 'display_passport_model.dart';

import 'package:flutterflow_ui/flutterflow_ui.dart';

class DisplayPassportWidget extends StatefulWidget {
  const DisplayPassportWidget({super.key});

  static String routeName = 'DisplayPassport';
  static String routePath = '/displayPassport';

  @override
  State<DisplayPassportWidget> createState() => _DisplayPassportWidgetState();
}

class _DisplayPassportWidgetState extends State<DisplayPassportWidget> {
  late DisplayPassportModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DisplayPassportModel());

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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0, -1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://picsum.photos/seed/965/600',
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.8,
                      fit: BoxFit.cover,
                      alignment: Alignment(0, 0),
                    ),
                  ),
                ),
              ),
              FFButtonWidget(
                onPressed: () {
                  print('Button pressed ...');
                },
                text: 'Button',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 40,
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
                  elevation: 0,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
