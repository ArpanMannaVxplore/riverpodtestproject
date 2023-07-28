import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodtestproject/pages/view%20model/second_screen_view_model.dart';

import '../view model/first_screen_view_model.dart';

class SecondScreen extends ConsumerStatefulWidget {
  const SecondScreen({super.key});

  @override
  ConsumerState<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends ConsumerState<SecondScreen> {
  onAdd(WidgetRef ref) {
    ref.read(homePageControllerProvider).addEntry(DateTime.now().toString());
  }

  onRemove(WidgetRef ref, String entry) {
    ref.read(homePageControllerProvider).removeEntry(entry);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text('Entries Management page 2'),
        automaticallyImplyLeading: false,
        actions: [
IconButton(onPressed: (){
  onSecondScreenNavClicked();
}, icon: const Icon( Icons.arrow_back_ios,color: Colors.black, ),)
        ],
      ),
      body: ref.watch(entriesProvider).when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, trace) => Center(child: Text(error.toString())),
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return ListTile(
              title: Text(item),
              onTap: () => onRemove(ref, item),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => onAdd(ref),
      ),
    ));
  }
}
