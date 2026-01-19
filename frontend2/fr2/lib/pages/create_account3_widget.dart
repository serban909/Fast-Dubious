import '/flutter_flow/flutter_flow_theme.dart';

import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'create_account3_model.dart';
export 'create_account3_model.dart';

import '../services/auth_api.dart';

class CreateAccount3Widget extends StatefulWidget {
  const CreateAccount3Widget({super.key});

  static String routeName = 'CreateAccount3';
  static String routePath = '/createAccount3';

  @override
  State<CreateAccount3Widget> createState() => _CreateAccount3WidgetState();
}

class _CreateAccount3WidgetState extends State<CreateAccount3Widget>
    with TickerProviderStateMixin {
  late CreateAccount3Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  String? _errorMessage;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateAccount3Model());

    _model.emailAddressFieldTextController ??= TextEditingController();
    _model.emailAddressFieldFocusNode ??= FocusNode();

    _model.passwordFieldTextController ??= TextEditingController();
    _model.passwordFieldFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.0, 140.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.9, 1.0),
            end: Offset(1.0, 1.0),
          ),
          TiltEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: Offset(-0.349, 0),
            end: Offset(0, 0),
          ),
        ],
      ),
    });

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
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                width: 100,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).primary,
                      FlutterFlowTheme.of(context).tertiary,
                    ],
                    stops: [0, 1],
                    begin: AlignmentDirectional(0.87, -1),
                    end: AlignmentDirectional(-0.87, 1),
                  ),
                ),
                alignment: AlignmentDirectional(0, -1),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 32),
                        child: Container(
                          width: 200,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'brand.ai',
                            style: FlutterFlowTheme.of(context).displaySmall
                                .override(
                                  font: 'Inter Tight',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(
                                    context,
                                  ).displaySmall.fontWeight,
                                  fontStyle: FlutterFlowTheme.of(
                                    context,
                                  ).displaySmall.fontStyle,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(maxWidth: 570),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(
                              context,
                            ).secondaryBackground,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x33000000),
                                offset: Offset(0, 2),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding: EdgeInsets.all(32),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Get Started',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .displaySmall
                                        .override(
                                          font: 'Inter Tight',
                                          letterSpacing: 0.0,
                                          fontWeight: FlutterFlowTheme.of(
                                            context,
                                          ).displaySmall.fontWeight,
                                          fontStyle: FlutterFlowTheme.of(
                                            context,
                                          ).displaySmall.fontStyle,
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0,
                                      12,
                                      0,
                                      24,
                                    ),
                                    child: Text(
                                      'Let\'s get started by filling out the form below.',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0,
                                      0,
                                      0,
                                      16,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: _model
                                            .emailAddressFieldTextController,
                                        focusNode:
                                            _model.emailAddressFieldFocusNode,
                                        autofocus: true,
                                        autofillHints: [AutofillHints.email],
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          labelStyle:
                                              FlutterFlowTheme.of(
                                                context,
                                              ).labelLarge.override(
                                                font: 'Inter Tight',
                                                letterSpacing: 0.0,
                                                fontWeight: FlutterFlowTheme.of(
                                                  context,
                                                ).labelLarge.fontWeight,
                                                fontStyle: FlutterFlowTheme.of(
                                                  context,
                                                ).labelLarge.fontStyle,
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).primaryBackground,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).primary,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).alternate,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).alternate,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                          filled: true,
                                          fillColor: FlutterFlowTheme.of(
                                            context,
                                          ).primaryBackground,
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
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: _model
                                            .emailAddressFieldTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0,
                                      0,
                                      0,
                                      16,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller:
                                            _model.passwordFieldTextController,
                                        focusNode:
                                            _model.passwordFieldFocusNode,
                                        autofocus: true,
                                        autofillHints: [AutofillHints.password],
                                        obscureText:
                                            !_model.passwordFieldVisibility,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          labelStyle:
                                              FlutterFlowTheme.of(
                                                context,
                                              ).labelLarge.override(
                                                font: 'Inter Tight',
                                                letterSpacing: 0.0,
                                                fontWeight: FlutterFlowTheme.of(
                                                  context,
                                                ).labelLarge.fontWeight,
                                                fontStyle: FlutterFlowTheme.of(
                                                  context,
                                                ).labelLarge.fontStyle,
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).primaryBackground,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).primary,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).error,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).error,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                          filled: true,
                                          fillColor: FlutterFlowTheme.of(
                                            context,
                                          ).primaryBackground,
                                          suffixIcon: InkWell(
                                            onTap: () => safeSetState(
                                              () => _model.passwordFieldVisibility =
                                                  !_model
                                                      .passwordFieldVisibility,
                                            ),
                                            focusNode: FocusNode(
                                              skipTraversal: true,
                                            ),
                                            child: Icon(
                                              _model.passwordFieldVisibility
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                        .visibility_off_outlined,
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).secondaryText,
                                              size: 24,
                                            ),
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
                                        validator: _model
                                            .passwordFieldTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  if (_errorMessage != null)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                        0,
                                        0,
                                        0,
                                        16,
                                      ),
                                      child: Text(
                                        _errorMessage!,
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: 'Inter Tight',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0,
                                      0,
                                      0,
                                      16,
                                    ),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        if (_isLoading) {
                                          return;
                                        }

                                        final email = _model
                                                .emailAddressFieldTextController
                                                ?.text
                                                .trim() ??
                                            '';
                                        final password = _model
                                                .passwordFieldTextController
                                                ?.text ??
                                            '';

                                        if (email.isEmpty || password.isEmpty) {
                                          safeSetState(
                                            () => _errorMessage =
                                                'Please enter email and password.',
                                          );
                                          return;
                                        }

                                        safeSetState(() {
                                          _isLoading = true;
                                          _errorMessage = null;
                                        });

                                        final result = await AuthApi.signup(
                                          email: email,
                                          password: password,
                                        );

                                        if (!mounted) {
                                          return;
                                        }

                                        safeSetState(() {
                                          _isLoading = false;
                                          _errorMessage =
                                              result.error ?? _errorMessage;
                                        });

                                        if (result.success) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Account created. Please sign in.',
                                              ),
                                            ),
                                          );
                                          Navigator.pop(context);
                                        }
                                      },
                                      text: _isLoading
                                          ? 'Creating Account...'
                                          : 'Create Account',
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 44,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          0,
                                          0,
                                          0,
                                          0,
                                        ),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                              0,
                                              0,
                                              0,
                                              0,
                                            ),
                                        color: FlutterFlowTheme.of(
                                          context,
                                        ).primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
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
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      16,
                                      0,
                                      16,
                                      24,
                                    ),
                                    child: Text(
                                      'Or sign up with',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0,
                                      0,
                                      0,
                                      16,
                                    ),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        print('Button pressed ...');
                                      },
                                      text: 'Continue with Google',
                                      icon: FaIcon(
                                        FontAwesomeIcons.google,
                                        size: 20,
                                      ),
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 44,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          0,
                                          0,
                                          0,
                                          0,
                                        ),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                              0,
                                              0,
                                              0,
                                              0,
                                            ),
                                        color: FlutterFlowTheme.of(
                                          context,
                                        ).secondaryBackground,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: 'Inter Tight',
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FlutterFlowTheme.of(
                                                context,
                                              ).titleSmall.fontWeight,
                                              fontStyle: FlutterFlowTheme.of(
                                                context,
                                              ).titleSmall.fontStyle,
                                            ),
                                        elevation: 0,
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).alternate,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        hoverColor: FlutterFlowTheme.of(
                                          context,
                                        ).primaryBackground,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      0,
                                      0,
                                      0,
                                      16,
                                    ),
                                    child: FFButtonWidget(
                                      onPressed: () {
                                        print('Button pressed ...');
                                      },
                                      text: 'Continue with Apple',
                                      icon: FaIcon(
                                        FontAwesomeIcons.apple,
                                        size: 20,
                                      ),
                                      options: FFButtonOptions(
                                        width: double.infinity,
                                        height: 44,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          0,
                                          0,
                                          0,
                                          0,
                                        ),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                              0,
                                              0,
                                              0,
                                              0,
                                            ),
                                        color: FlutterFlowTheme.of(
                                          context,
                                        ).secondaryBackground,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: 'Inter Tight',
                                              color: FlutterFlowTheme.of(
                                                context,
                                              ).primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FlutterFlowTheme.of(
                                                context,
                                              ).titleSmall.fontWeight,
                                              fontStyle: FlutterFlowTheme.of(
                                                context,
                                              ).titleSmall.fontStyle,
                                            ),
                                        elevation: 0,
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(
                                            context,
                                          ).alternate,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        hoverColor: FlutterFlowTheme.of(
                                          context,
                                        ).primaryBackground,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
