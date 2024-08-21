import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class DocumentUploadScreen extends StatefulWidget {
  @override
  _DocumentUploadScreenState createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  List<PlatformFile> _selectedFiles = [];

  Future<void> _pickFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true, // Allow multiple file selection
      );
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFiles = result.files;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No files selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking files: $e')),
      );
    }
  }

  Future<void> _uploadFiles() async {
    if (_selectedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No files selected to upload')),
      );
      return;
    }

    try {
      // Replace with your server URL
      final uri = Uri.parse('https://your-server.com/upload');
      final request = http.MultipartRequest('POST', uri);

      // Add each selected file to the request
      for (var file in _selectedFiles) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'files',
            file.bytes!,
            filename: file.name,
          ),
        );
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Files uploaded successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload files.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading files: $e')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Document Upload', style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color.fromARGB(255, 19, 75, 146),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_selectedFiles != null)
                  Text('Selected file: ${_selectedFiles.map((file) => file.name).join(',\n')}'),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 19, 75, 146)),
                  onPressed: _pickFiles,
                  child: Text('Pick a Document', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 19, 75, 146)),
              onPressed: _uploadFiles,
              child: Text('Upload Document', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
