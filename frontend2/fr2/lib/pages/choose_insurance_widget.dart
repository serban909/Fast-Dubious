import 'package:flutter/material.dart';

import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:fr2/pages/enter_car_data_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../services/insurance_api.dart';
import 'display_passport_widget.dart'; // Reuse for display

class ChooseInsuranceWidget extends StatefulWidget {
  const ChooseInsuranceWidget({super.key});

  static String routeName = 'ChooseInsurance';
  static String routePath = '/chooseInsurance';

  @override
  State<ChooseInsuranceWidget> createState() => _ChooseInsuranceWidgetState();
}

class _ChooseInsuranceWidgetState extends State<ChooseInsuranceWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedInsuranceIndex = -1;
  List<dynamic> _insurances = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPolicies();
  }

  Future<void> _fetchPolicies() async {
    final policies = await InsuranceApi.getMyPolicies();
    if (mounted) {
      setState(() {
        _insurances = policies;
        _isLoading = false;
      });
    }
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
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 30,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          actions: const [],
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Insurance',
                      style: FlutterFlowTheme.of(context).displaySmall.override(
                            font: 'Inter Tight',
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .displaySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .displaySmall
                                .fontStyle,
                          ),
                    ),
                    const Divider(
                      height: 24,
                      thickness: 1,
                      color: Color(0xFFE0E3E7),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                      child: Text(
                        'Choose one to display',
                        style: FlutterFlowTheme.of(context).labelMedium.override(
                              font: 'Inter Tight',
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                    _isLoading 
                      ? const Center(child: CircularProgressIndicator())
                      : (_insurances.isEmpty 
                        ? const Center(child: Text("No insurance policies found."))
                        : ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _insurances.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final insurance = _insurances[index];
                        final isSelected = _selectedInsuranceIndex == index;
                        
                        // Map backend fields
                        final name = "Policy ${insurance['series']}/${insurance['number']}";
                        final subtitle = "Valid: ${insurance['validity_start']} - ${insurance['validity_end']}";
                        // Image URL logic
                        String? imageUrl = insurance['policy_document'];
                        if (imageUrl != null && !imageUrl.startsWith('http')) {
                            imageUrl = "http://localhost:8000$imageUrl";
                        }
                        // Fallback icon if no image
                        final hasImage = imageUrl != null;

                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              _selectedInsuranceIndex = index;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? FlutterFlowTheme.of(context)
                                      .primary
                                      .withValues(alpha: 0.08)
                                  : FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 7,
                                  color: Color(0x32171717),
                                  offset: Offset(0.0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: hasImage
                                      ? Image.network(
                                          imageUrl!,
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                          errorBuilder: (c, e, s) => const Icon(Icons.description, size: 40),
                                        )
                                      : const Icon(Icons.description, size: 40, color: Colors.grey),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                            16,
                                            0,
                                            16,
                                            0,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                name,
                                                style: FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .override(
                                                      font: 'Inter Tight',
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyLarge
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                    ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                  0,
                                                  4,
                                                  0,
                                                  0,
                                                ),
                                                child: Text(
                                                  subtitle,
                                                  style: FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .override(
                                                        font: 'Inter Tight',
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(context)
                                                                .labelSmall
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                            70,
                                            0,
                                            0,
                                            0,
                                          ),
                                          child: Icon(
                                            isSelected
                                                ? Icons.radio_button_checked
                                                : Icons.radio_button_off,
                                            color: isSelected
                                                ? FlutterFlowTheme.of(context)
                                                    .primary
                                                : FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                            size: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -1),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        0,
                        0,
                        0,
                        20,
                      ),
                      child: FFButtonWidget(
                        onPressed: () async {
                           if (_selectedInsuranceIndex == -1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please select an insurance policy first.')),
                            );
                            return;
                          }
                          final insurance = _insurances[_selectedInsuranceIndex];
                          String? imageUrl = insurance['policy_document'];
                          
                          if (imageUrl == null) {
                             ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('No document image for this policy.')),
                            );
                            return;
                          }
                          
                          if (!imageUrl.startsWith('http')) {
                            imageUrl = "http://localhost:8000$imageUrl";
                          }

                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DisplayPassportWidget(
                                photoUrl: imageUrl!, // Reuse the passport display logic
                              ),
                            ),
                          );
                        },
                        text: 'Display Selected Insurance',
                        options: FFButtonOptions(
                          width: 270,
                          height: 40,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            0,
                            0,
                            0,
                            0,
                          ),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0,
                            0,
                            0,
                            0,
                          ),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                font: 'Inter Tight',
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                          elevation: 3,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        0,
                        0,
                        0,
                        20,
                      ),
                      child: FFButtonWidget(
                        onPressed: () async {
                           Navigator.pushNamed(
                             context,
                             EnterCarDataWidget.routePath,
                           );
                        },
                        text: 'Make  a new Insurance',
                        options: FFButtonOptions(
                          width: 270,
                          height: 40,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            0,
                            0,
                            0,
                            0,
                          ),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                            0,
                            0,
                            0,
                            0,
                          ),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                font: 'Inter Tight',
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                          elevation: 3,
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
