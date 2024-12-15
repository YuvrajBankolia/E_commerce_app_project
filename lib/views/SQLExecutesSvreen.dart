import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SQLExecutorScreen extends StatelessWidget {
  Future<void> runCommand(String command) async {
    switch (command) {
      case 'checkTableExists':
        await checkIfTableExists();
        break;
      case 'viewAllRows':
        await viewAllRows();
        break;
      case 'insertData':
        await insertSampleData();
        break;
      case 'checkRows':
        await checkSpecificRows();
        break;
      default:
        print('Invalid command');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SQL Executor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => runCommand('checkTableExists'),
              child: Text('Check if Table Exists'),
            ),
            ElevatedButton(
              onPressed: () => runCommand('viewAllRows'),
              child: Text('View All Rows'),
            ),
            ElevatedButton(
              onPressed: () => runCommand('insertData'),
              child: Text('Insert Sample Data'),
            ),
            ElevatedButton(
              onPressed: () => runCommand('checkRows'),
              child: Text('Check Specific Rows'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkIfTableExists() async {
    try {
      final response = await Supabase.instance.client
          .from('information_schema.tables')
          .select('table_name')
          .eq('table_schema', 'public');

      print('Tables: ${response}');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> viewAllRows() async {
    try {
      final response =
          await Supabase.instance.client.from('countries').select();

      print('Rows: ${response}');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> insertSampleData() async {
    try {
      final response = await Supabase.instance.client.from('countries').insert([
        {'name': 'Canada'},
        {'name': 'United States'},
        {'name': 'Mexico'}
      ]);

      print('Insert Response: ${response}');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> checkSpecificRows() async {
    try {
      final response = await Supabase.instance.client
          .from('countries')
          .select()
          .eq('name', 'Germany');

      print('Specific Rows: ${response}');
    } catch (e) {
      print('Error: $e');
    }
  }
}
