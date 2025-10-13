import 'package:flutter/material.dart';

class Client {
  Client({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.ssn,
    required this.vehicles,
    required this.lastPolicyIssued,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String ssn;
  final List<Vehicle> vehicles;
  final DateTime lastPolicyIssued;
}

class Vehicle {
  Vehicle({
    required this.make,
    required this.model,
    required this.year,
    required this.vin,
    required this.plate,
  });

  final String make;
  final String model;
  final int year;
  final String vin;
  final String plate;
}

class PolicyTemplate {
  PolicyTemplate({
    required this.provider,
    required this.planName,
    required this.coverageLevel,
    required this.accent,
    required this.description,
  });

  final String provider;
  final String planName;
  final String coverageLevel;
  final Color accent;
  final String description;
}

class SampleData {
  static final List<Client> clients = [
    Client(
      id: 'c-001',
      name: 'Aria Winters',
      email: 'aria.winters@mail.com',
      phone: '+1 (212) 555-0108',
      address: '265 Mercer Street, New York, NY',
      ssn: '123-44-9821',
      vehicles: [
        Vehicle(
          make: 'Audi',
          model: 'Q4 e-tron',
          year: 2023,
          vin: 'WA1EVAFM7P1234567',
          plate: 'NY - EV4021',
        ),
        Vehicle(
          make: 'Mini',
          model: 'Cooper SE',
          year: 2021,
          vin: 'WMW13DJ02N2F88234',
          plate: 'NY - MINI42',
        ),
      ],
      lastPolicyIssued: DateTime(2024, 7, 3),
    ),
    Client(
      id: 'c-002',
      name: 'Matei Popescu',
      email: 'matei.popescu@mail.com',
      phone: '+40 723 555 210',
      address: 'Strada Paris 12, București',
      ssn: '268-55-7129',
      vehicles: [
        Vehicle(
          make: 'Dacia',
          model: 'Spring Extreme',
          year: 2024,
          vin: 'UU15SDA7544K91234',
          plate: 'B 55 SPR',
        ),
      ],
      lastPolicyIssued: DateTime(2024, 4, 18),
    ),
    Client(
      id: 'c-003',
      name: 'Zoe Martínez',
      email: 'zoe.martinez@mail.com',
      phone: '+34 611 555 884',
      address: 'Calle de Serrano 108, Madrid',
      ssn: '442-88-1065',
      vehicles: [
        Vehicle(
          make: 'Tesla',
          model: 'Model Y Performance',
          year: 2022,
          vin: '5YJYGDEF7MF123450',
          plate: 'ES - ZM 2207',
        ),
        Vehicle(
          make: 'Seat',
          model: 'Arona',
          year: 2020,
          vin: 'VSSZZZKJZLR123876',
          plate: 'ES - 2207 ZM',
        ),
      ],
      lastPolicyIssued: DateTime(2023, 12, 2),
    ),
  ];

  static final List<PolicyTemplate> policies = [
    PolicyTemplate(
      provider: 'Groupama',
      planName: 'Catalyst Fleet',
      coverageLevel: 'Premium',
      accent: const Color(0xFF2ECC71),
      description:
          'Premium liability + collision coverage with rapid roadside support and EU roaming assistance.',
    ),
    PolicyTemplate(
      provider: 'Allianz',
      planName: 'Quantum Shield',
      coverageLevel: 'Elite',
      accent: const Color(0xFF3498DB),
      description:
          'Elite coverage with automated claims processing and dedicated underwriter concierge.',
    ),
    PolicyTemplate(
      provider: 'Tesla',
      planName: 'Autopilot Secure',
      coverageLevel: 'Performance',
      accent: const Color(0xFFE74C3C),
      description:
          'Tailored EV coverage with battery health guarantees and autonomous hardware protection.',
    ),
    PolicyTemplate(
      provider: 'ING',
      planName: 'Edge Mobility',
      coverageLevel: 'Advanced',
      accent: const Color(0xFFFF9800),
      description:
          'Cross-border coverage, telematics scoring incentives, and flexible deductible options.',
    ),
    PolicyTemplate(
      provider: 'BCR',
      planName: 'Guardian Drive',
      coverageLevel: 'Preferred',
      accent: const Color(0xFF9B59B6),
      description:
          'Solid base coverage with add-ons for business use, glass protection, and replacement vehicle.',
    ),
  ];
}