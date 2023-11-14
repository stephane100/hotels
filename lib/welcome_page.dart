import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as gf;
import 'Constant/color.dart';
import 'package:intl/intl.dart';
class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String date_range = 'Date Range';
  List<String> cities = ['Select Nationality', 'City 2', 'City 3'];
  String selectedCity = 'Select Nationality';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/images/attachement.jpeg', // Update the path to your image
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Content containers on top of the image
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 320,
              margin: EdgeInsets.symmetric(
                vertical: 80,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue, // Make the background color transparent
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Red container above the blue container
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        'Hotels Search',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Blue container with the rest of the content
                  Container(
                    width: 330, // Set your desired width
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Select city',
                            hintStyle: TextStyle(color: Colors.blue),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 10),

                        Container(
                          width: 330, // Set your desired width
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: StadiumBorder(),
                              padding: EdgeInsets.all(13),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$date_range',
                                  style: TextStyle(fontSize: 20, color: Colors.blue),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.date_range,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            onPressed: () async {
                              String? selectedDateRange = await _showDateRangePicker(context);
                              if (selectedDateRange != null) {
                                setState(() {
                                  date_range = selectedDateRange;
                                });
                              }
                            },
                          ),
                        ),

                        SizedBox(height: 10),

                        // City Dropdown
                        Container(
                          width: 330,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only(bottom: 8),
                          child: Center(
                            child: DropdownButton<String>(
                              value: selectedCity,
                              icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                              iconSize: 50,
                              elevation: 14,
                              style: TextStyle(color: Colors.blue),
                              underline: Container(
                                height: 2,
                                color: Colors.transparent,
                              ),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedCity = newValue;
                                  });
                                }
                              },
                              items: cities.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),

                        // ... Rest of your content

                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.secondaryColor,
                            shape: StadiumBorder(),
                            padding: EdgeInsets.all(10),
                          ),
                          onPressed: () {
                            _showModal(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Find hotels'),
                              SizedBox(width: 8),
                              Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }






  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey,
      builder: (BuildContext builder) {
        return NumberModifierModal();
      },
    );
  }
  Future<String?> _showDateRangePicker(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (picked != null && picked.start != null && picked.end != null) {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      String formattedStartDate = dateFormat.format(picked.start);
      String formattedEndDate = dateFormat.format(picked.end);

      return '$formattedStartDate => $formattedEndDate';
    }

    return null;
  }
}

class NumberModifierModal extends StatefulWidget {
  @override
  _NumberModifierModalState createState() => _NumberModifierModalState();
}

class _NumberModifierModalState extends State<NumberModifierModal> {
  int number_rooms = 1;
  int number_adult = 1;
  int number_child = 1;

  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child:
    Container(
      padding: EdgeInsets.all(16),


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // rooms
          Container(
            padding: EdgeInsets.only(left: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [


                    Expanded(
                      child: Text(
                        'Rooms',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // Couleur de fond blanche
                        shape: CircleBorder(
                          side: BorderSide(
                            color: Colors.blue, // Couleur de la bordure bleue
                            width: 2.0, // Épaisseur de la bordure
                          ),
                        ),
                        padding: EdgeInsets.all(1),
                      ),
                      child: Icon(Icons.remove,
                          color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          number_rooms = (number_rooms > 1) ? number_rooms - 1 : 1;
                        });
                      },
                    ),
                    Text(
                      '$number_rooms',
                      style: TextStyle(fontSize: 20),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // Couleur de fond blanche
                        shape: CircleBorder(
                          side: BorderSide(
                            color: Colors.blue, // Couleur de la bordure bleue
                            width: 2.0, // Épaisseur de la bordure
                          ),
                        ),
                        padding: EdgeInsets.all(1),
                      ),
                      child: Icon(Icons.add,
                          color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          number_rooms ++;
                        });
                      },
                    ),
                  ],
                ),



              ],
            ),
          ),

          SizedBox(height: 10),
          //rooms 1

          Container(
            padding: EdgeInsets.only(left: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Expanded(
                      child: Text(
                        'ROOM 1',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                ]
              ),
                SizedBox(height: 5),

                //adults
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Adults',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // Couleur de fond blanche
                        shape: CircleBorder(
                          side: BorderSide(
                            color: Colors.blue, // Couleur de la bordure bleue
                            width: 2.0, // Épaisseur de la bordure
                          ),
                        ),
                        padding: EdgeInsets.all(1),
                      ),
                      child: Icon(Icons.remove,
                          color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          number_adult = (number_adult > 1) ? number_adult - 1 : 1;
                        });
                      },
                    ),
                    Text(
                      '$number_adult',
                      style: TextStyle(fontSize: 20),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // Couleur de fond blanche
                        shape: CircleBorder(
                          side: BorderSide(
                            color: Colors.blue, // Couleur de la bordure bleue
                            width: 2.0, // Épaisseur de la bordure
                          ),
                        ),
                        padding: EdgeInsets.all(1),
                      ),
                      child: Icon(Icons.add,
                          color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          number_adult++;
                        });
                      },
                    ),
                  ],
                ),
                //children
                SizedBox(height: 5), // Ajout d'un espace vertical
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Children',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // Couleur de fond blanche
                        shape: CircleBorder(
                          side: BorderSide(
                            color: Colors.blue, // Couleur de la bordure bleue
                            width: 2.0, // Épaisseur de la bordure
                          ),
                        ),
                        padding: EdgeInsets.all(1),
                      ),
                      child: Icon(Icons.remove,
                        color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          number_child = (number_child > 1) ? number_child - 1 : 1;
                        });
                      },
                    ),

                    Text(
                      '$number_child',
                      style: TextStyle(fontSize: 20),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // Couleur de fond blanche
                        shape: CircleBorder(
                          side: BorderSide(
                            color: Colors.blue, // Couleur de la bordure bleue
                            width: 2.0, // Épaisseur de la bordure
                          ),
                        ),
                        padding: EdgeInsets.all(1),
                      ),
                      child: Icon(Icons.add,
                          color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          number_child++;
                        });
                      },
                    ),
                  ],
                ),
                //aged of child 1
                SizedBox(height: 5), // Ajout d'un espace vertical
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Aged of child 1',
                      style: TextStyle(fontSize: 20),
                    ),

                    Text(
                      '14 years',
                      style: TextStyle(fontSize: 20),
                    ),

                  ],
                ),
                SizedBox(height: 20), // Ajout d'un espace vertical

                //aged of child 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Aged of child 2',
                      style: TextStyle(fontSize: 20),
                    ),

                    Text(
                      '14 years',
                      style: TextStyle(fontSize: 20),
                    ),

                  ],
                ),

              ],
            ),
          ),
          SizedBox(height: 10),
          // pet friendly
          Container(
            padding: EdgeInsets.only(left: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Pet-friendly',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 8), // Espacement entre le texte et l'icône
                          Icon(
                            Icons.info_outline,
                            color: Colors.blue, // Couleur de l'icône
                          ),
                        ],
                      ),
                    ),
                    Switch(

                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                      activeColor: AppColors.primaryColor, // Couleur lorsque le bouton est activé
                      inactiveThumbColor: Colors.white, // Couleur lorsque le bouton est désactivé
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Pet-friendly',
                      style: TextStyle(fontSize: 20),
                    ),

                  ],
                ),



              ],
            ),
          ),



          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppColors.primaryColor,
              shape: StadiumBorder(),
              padding: EdgeInsets.all(13),
            ),
            child: Text('Apply'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
    );
  }
}
