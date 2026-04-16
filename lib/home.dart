import 'package:flutter/material.dart';

// CUSTOM WIDGET CLASS: MYTEXTWIDGET
// Using Stateless Widget for a reusable UI component
class MyTextWidget extends StatelessWidget {
  final String label;
  const MyTextWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
    );
  }
}

// STATEFUL CLASS
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState(); // Creating the STATE CLASS
}

class _HomeState extends State<Home> {
  // THE TEXTEDITINGCONTROLLER: Managing the input field
  final TextEditingController _destinationController = TextEditingController();

  // State Variables
  String _transportType = 'Car';
  bool _isBusinessTrip = false;
  int _priority = 1; // 1 for Normal, 2 for Urgent
  final List<String> _tripSummary = [];

  // DISPOSE DESTRUCTOR
  // Triggered when the object is removed permanently from the widget tree
  @override
  void dispose() {
    // Good practice: Dispose of the controller when not used anymore
    _destinationController.dispose();
    super.dispose();
  }

  // updateText function using callback logic
  void _updateSummary() {
    // The setState method: Notifying Flutter to rebuild the UI
    setState(() {
      String destination = _destinationController.text;

      if (destination.isNotEmpty) {
        _tripSummary.add("To: $destination | Type: $_transportType | Business: $_isBusinessTrip");
        _destinationController.clear(); // Clearing the field after adding
      } else {
        // Using BuildContext to show a SnackBar (Feedback)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a destination name!")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) { // CONTEXT IN FLUTTER
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quick Trip Planner"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
        leading: const Icon(Icons.travel_explore), // FLUTTER ICONS
      ),
      // Using SingleChildScrollView to avoid overflow
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Handling Logical Pixels
        child: Column( // COLUMN WIDGET
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MyTextWidget(label: "Plan Your Next Destination"),
            const SizedBox(height: 15), // SizedBox for spacing

            // THE TEXTFIELDWIDGET with InputDecoration
            TextField(
              controller: _destinationController,
              decoration: const InputDecoration(
                labelText: "Destination Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.map),
              ),
              // onChanged method can be used for real-time validation
              onChanged: (value) {
                // Logic can be added here if needed
              },
            ),

            const SizedBox(height: 20),

            // ROW WIDGET for Checkbox
            Row(
              children: [
                const Text("Business Trip:"),
                Checkbox( // Checkbox widget
                  value: _isBusinessTrip,
                  onChanged: (bool? value) {
                    setState(() { _isBusinessTrip = value!; });
                  },
                ),
              ],
            ),

            const Text("Transport Mode:", style: TextStyle(fontWeight: FontWeight.bold)),
            // The DropDownMenu widget
            DropdownButton<String>(
              value: _transportType,
              isExpanded: true,
              items: <String>['Car', 'Bus', 'Plane', 'Train'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() { _transportType = newValue!; });
              },
            ),

            const SizedBox(height: 10),
            const Text("Priority Level:", style: TextStyle(fontWeight: FontWeight.bold)),
            Row( // Radio button widgets
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: _priority,
                  onChanged: (int? value) {
                    setState(() { _priority = value!; });
                  },
                ),
                const Text("Normal"),
                const SizedBox(width: 20),
                Radio<int>(
                  value: 2,
                  groupValue: _priority,
                  onChanged: (int? value) {
                    setState(() { _priority = value!; });
                  },
                ),
                const Text("Urgent"),
              ],
            ),

            const SizedBox(height: 20),

            // THE ELEVATEDBUTTONWIDGET
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _updateSummary, // Callback function
                icon: const Icon(Icons.add),
                label: const Text("ADD TRIP TO LIST"),
              ),
            ),

            const Divider(height: 40, thickness: 2),
            const MyTextWidget(label: "Recent Trips Summary"),
            const SizedBox(height: 10),

            // ListViews: Displaying data dynamically
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _tripSummary.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.flight_takeoff, color: Colors.blue),
                    title: Text(_tripSummary[index]),
                    trailing: const Icon(Icons.check_circle, color: Colors.green),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}