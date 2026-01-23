import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import 'display_insurance_model.dart';
export 'display_insurance_model.dart';

import 'package:flutterflow_ui/flutterflow_ui.dart';

class DisplayInsuranceWidget extends StatefulWidget {
  const DisplayInsuranceWidget({
    super.key,
    required this.policyUrl,
  });

  final String policyUrl;

  static String routeName = 'DisplayInsurance';
  static String routePath = '/displayInsurance';

  @override
  State<DisplayInsuranceWidget> createState() => _DisplayInsuranceWidgetState();
}

class _DisplayInsuranceWidgetState extends State<DisplayInsuranceWidget> {
  late DisplayInsuranceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DisplayInsuranceModel());

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
              Align(
                alignment: AlignmentDirectional(0, -1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.policyUrl,
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height * 0.75,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => 
                        const Center(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image, size: 50, color: Colors.grey),
                            Text("Image not found"),
                          ],
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  text: 'Back',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
