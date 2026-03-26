import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  static const Color primaryBlue = Color(0xFF13384A);

  Future<void> _callNumber(BuildContext context, String number) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not call $number')),
      );
    }
  }

  void _showCallDialog(BuildContext context, String title, String number) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text('Do you want to call $number now?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _callNumber(context, number);
            },
            child: const Text('Call'),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: title == 'Helpline'
            ? RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          "You don’t have to go through this alone.\n\nIf you're struggling or feeling overwhelmed, there are people who care and want to listen.\n\nPlease consider reaching out to the helpline below.\n\n",
                    ),
                    TextSpan(
                      text: 'Call 116 123',
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(dialogContext);
                          _callNumber(context, '116123');
                        },
                    ),
                  ],
                ),
              )
            : Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Emergency Quick Access',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 26, 18, 24),
          child: Column(
            children: [
              _MainEmergencyButton(
                text: 'CALL 999 NOW',
                onTap: () {
                  _showCallDialog(context, 'Emergency Services', '999');
                },
              ),
              const SizedBox(height: 26),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.05,
                children: [
                  _EmergencyOptionCard(
                    icon: Icons.local_police,
                    title: 'Police',
                    onTap: () {
                      _showCallDialog(context, 'Police Emergency', '999');
                    },
                  ),
                  _EmergencyOptionCard(
                    icon: Icons.medical_services,
                    title: 'Ambulance',
                    onTap: () {
                      _showCallDialog(context, 'Ambulance Emergency', '999');
                    },
                  ),
                  _EmergencyOptionCard(
                    icon: Icons.local_fire_department,
                    title: 'Fire Service',
                    onTap: () {
                      _showCallDialog(context, 'Fire Service Emergency', '999');
                    },
                  ),
                  _EmergencyOptionCard(
                    icon: Icons.health_and_safety,
                    title: 'NHS 111\nUrgent Advice',
                    onTap: () {
                      _showCallDialog(context, 'NHS Urgent Advice', '111');
                    },
                  ),
                  _EmergencyOptionCard(
                    icon: Icons.support_agent,
                    title: '101\nNon-Emergency',
                    onTap: () {
                      _showCallDialog(context, 'Police Non-Emergency', '101');
                    },
                  ),
                  _EmergencyOptionCard(
                    icon: Icons.headset_mic,
                    title: 'Helpline',
                    onTap: () {
                      _showInfoDialog(context, 'Helpline', '');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _WideInfoButton(
                icon: Icons.help,
                text: 'When to Call ?',
                onTap: () {
                  _showInfoDialog(
                    context,
                    'When to Call',
                    'Call 999 for immediate danger, serious injury, fire, crime in progress, or when urgent emergency help is needed.\n\nCall 101 for police non-emergencies.\n\nCall 111 for urgent medical advice when it is not life-threatening.',
                  );
                },
              ),
              const SizedBox(height: 18),
              _WideInfoButton(
                icon: Icons.language,
                text: 'Language Support',
                onTap: () {
                  _showInfoDialog(
                    context,
                    'Language Support',
                    'If English is not your first language, emergency services can often arrange interpreter support. Stay calm, say your location clearly, and explain the emergency as simply as possible.',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainEmergencyButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _MainEmergencyButton({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 72,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class _EmergencyOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _EmergencyOptionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFDCE5E8), width: 1.2),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 28,
                color: const Color(0xFF13384A),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  color: Color(0xFF13384A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WideInfoButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _WideInfoButton({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 76,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFFDCE5E8), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF13384A), size: 32),
            const SizedBox(width: 14),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF13384A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}