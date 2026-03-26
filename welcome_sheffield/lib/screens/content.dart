import 'package:flutter/material.dart';
class PageContent {
  final String title;
  final String intro;
  final String info;
  final String image;

  PageContent({
    required this.title,
    required this.intro,
    required this.info,
    required this.image,
  });
}


final Map<String, PageContent> contentData = {
  "Waste & Recycling": PageContent(
    title: "Waste & Recycling",

    intro: "Manage your bins and recycling services in Sheffield.",


    info: """
Put your bins out before 7am on your collection day. Sheffield City Council provides different bins for different types of waste.

Your bins:
• Black bin – general waste
• Blue bin – recycling (paper, plastic, cans)
• Brown bin – garden waste (if you have one)

Recycling tips:
• Rinse bottles and cans before recycling
• Do not put food waste in recycling bins
• Flatten cardboard to save space

Bulky waste:
You can arrange a bulky waste collection for large items like sofas or beds. There may be a small charge.

Recycling centres:
You can take items like electronics, wood and metal to local recycling centres across Sheffield.

If your bin is missed or damaged, you can report it using the contact form in this app.
""",
     image:  "assets/images/waste.png",

  ),



  "Roads, Pavements & Transport": PageContent(
    title: "Roads, Pavements & Transport",
    intro: "Report problems and travel safely in Sheffield.",
    info: """
Sheffield City Council looks after roads, pavements and street lighting.

Report problems:
• Potholes
• Broken pavements
• Faulty street lights
• Blocked drains

Parking:
Some areas need parking permits. There are also rules for parking zones.

Travel:
Sheffield has buses, trams and cycle routes.

If you see a problem, report it using the contact form in this app.
""",
      image:  "assets/images/Sheffield_Parkway.png",
  ),



  "Housing & Property": PageContent(
    title: "Housing & Property",
    intro: "Find housing services and support in Sheffield.",
    info: """
Sheffield City Council helps with housing and property services.

Council housing:
• Apply for housing
• Join the waiting list
• Priority is based on need

Repairs:
Report issues like:
• Heating problems
• Plumbing issues
• Structural damage

Private renting:
• Get advice about landlords
• Report unsafe housing
• Learn your rights

If you need help, use the contact form in this app.
""",
      image:  "assets/images/Housing.png",
  ),




  "Community & Safety": PageContent(
    title: "Community & Safety",
    intro: "Stay safe and report issues in your area.",
    info: """
Sheffield City Council works with local services to keep communities safe.

You can:
• Report anti-social behaviour
• Report noise problems
• Get advice on staying safe

Support:
• Local safety teams
• Crime prevention advice

Use the contact form in this app if you need help.
""",
      image:  "assets/images/community.png",
  ),


  "Emergencies & Severe Weather": PageContent(
    title: "Emergencies & Severe Weather",
    intro: "Stay safe during emergencies in Sheffield.",
    info: """
Sheffield City Council provides updates during bad weather and emergencies.

Examples:
• Floods
• Snow and ice
• Storms

Advice:
• Stay indoors when needed
• Follow safety instructions
• Keep emergency contacts ready

In an emergency call 999.

For other help, use the contact form in this app.
""",
      image:  "assets/images/weather.png",
  ),



  "Housing & Homeless": PageContent(
    title: "Housing & Homeless",
    intro: "Get help if you are homeless or at risk.",
    info: """
Sheffield City Council supports people who are homeless or at risk.

Support includes:
• Emergency accommodation
• Housing advice
• Temporary housing

If you are at risk:
• Contact support as soon as possible
• Ask for help early

Use the contact form in this app to get support.
""",
      image:  "assets/images/Homeless.png",
  ),



  "Families and Education": PageContent(
    title: "Families and Education",
    intro: "Support for families, children and schools.",
    info: """
Sheffield City Council supports education and family services.

You can:
• Apply for school places
• Find school information
• Get free school meals
• Access childcare support

Support:
• Help for parents
• Services for young people

Use the contact form in this app for help.
""",
      image:  "assets/images/family.png",
  ),



  "Public Spaces": PageContent(
    title: "Public Spaces",
    intro: "Enjoy parks and outdoor spaces in Sheffield.",
    info: """
Sheffield has many parks and green spaces.

You can:
• Visit parks and playgrounds
• Use walking and cycling paths
• Enjoy outdoor areas

Report problems:
• Litter
• Damage
• Unsafe areas

Use the contact form in this app to report issues.
""",
      image:  "assets/images/Public_spaces.png",
  ),



  "Libraries, learning and help": PageContent(
    title: "Libraries, learning and help",
    intro: "Use Sheffield libraries and learning support.",
    info: """
Libraries in Sheffield offer free services for everyone.

You can:
• Borrow books and DVDs
• Use computers and Wi-Fi
• Print documents

Learning support:
• Job search help
• CV writing
• Basic digital skills

Libraries are safe places to study and learn.

Use the contact form in this app for help.
""",

      image:  "assets/images/libraries.png",
  ),


  "Health & Care": PageContent(
    title: "Health & Care",
    intro: "Find health and care services in Sheffield.",
    info: """
Sheffield City Council works with the NHS to provide care.

Services include:
• GP doctors
• Hospitals
• Mental health support

Care support:
• Help for older adults
• Support for disabilities
• Services for families

In an emergency call 999.

Use the contact form in this app for support.
""",
      image:  "assets/images/nhs.png",
  ),



  "Benefits and Cost of Living": PageContent(
    title: "Benefits and Cost of Living",
    intro: "Get help with money and living costs.",
    info: """
Sheffield City Council provides financial support.

You can:
• Apply for benefits
• Get council tax support
• Get help with energy bills

Extra help:
• Food banks
• Budget advice
• Cost of living support

Use the contact form in this app if you need help.
""",
    image: "assets/images/waste.png",
  ),


  "Events and Tourism": PageContent(
    title: "Events and Tourism",
    intro: "Discover things to do in Sheffield.",
    info: """
Sheffield has many events and attractions.

You can:
• Visit museums
• Explore parks
• Attend local events

Tourism:
• Family activities
• Cultural events
• Outdoor spaces

Use the contact form in this app for information.
""",
    image: "assets/images/waste.png",
  ),


  "Disability and Accessibility": PageContent(
    title: "Disability and Accessibility",
    intro: "Accessible services and support in Sheffield.",
    info: """
Sheffield City Council supports people with disabilities.

Support includes:
• Accessible transport
• Accessible buildings
• Care support

Help:
• Advice for daily living
• Support services

Use the contact form in this app for help.
""",
    image: "assets/images/waste.png",
  ),

  "Legal Rights and Immigration": PageContent(
    title: "Legal Rights and Immigration",
    intro: "Get help with legal rights and immigration.",
    info: """
Support is available for legal and immigration advice.

You can:
• Learn about your rights
• Get immigration advice
• Find local support services

Help:
• Guidance from support organisations
• Advice for your situation

Use the contact form in this app for help.
""",
    image: "assets/images/waste.png",
  ),


};

class ContentPage extends StatelessWidget {
  final PageContent content;

  const ContentPage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF174A5C), 
      body: SafeArea(
        child: Column(
          children: [


            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    content.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),


            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Icon(Icons.image, size: 50),
                        ),
                      ),

                      const SizedBox(height: 20),


                      Text(
                        "Section Heading",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        content.info,
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 30),


                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Icon(Icons.image, size: 40),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Another Section",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "More placeholder text for future content pages.",
                        style: TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 40),
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
