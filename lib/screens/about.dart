import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            _buildInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange[800]!,
            Colors.orange[400]!,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 60.0,
              color: Colors.blue[900],
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'John Doe',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            'Flutter Developer',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange[900],
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu sapien ut leo pretium scelerisque. Etiam tristique leo eu sagittis vestibulum. Nam non dapibus elit. Aenean consectetur enim ac lorem accumsan, nec vestibulum ante dapibus. Nam efficitur semper nisl, sit amet bibendum nibh mollis a. Aliquam porta metus in ipsum venenatis, eu sollicitudin sapien commodo. Nam ac mauris diam. Maecenas pharetra risus eget eros mollis, quis aliquam mi accumsan. Vestibulum eleifend nisi eu dolor luctus pharetra. Nullam vel lacinia justo, id bibendum magna. Aenean luctus turpis ac turpis tincidunt vulputate. ',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Contact',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange[900],
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Email: john.doe@gmail.com',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            'Phone: 123-456-7890',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
