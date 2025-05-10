import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagegenerator/feature/prompt/bloc/prompt_bloc.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreenState();
}

class _CreatePromptScreenState extends State<CreatePromptScreen> {
  TextEditingController controller = new TextEditingController();
  final PromptBloc promptBloc = PromptBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    promptBloc.add(PromptInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Generate Images")),
      ),
      body: BlocConsumer<PromptBloc, PromptState>(
        bloc: promptBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case GenerateImagePromptLoadState:
              return Center(
                child: CircularProgressIndicator(),
              );

            case GenerateImagePromptErrorState:
              return Center(
                child: Text('Something went wrong'),
              );

            case GenerateImagePromptSuccessState:
              final successState = state as GenerateImagePromptSuccessState;
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(successState.uint8list))),
                    )),
                    Container(
                      height: 240,
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Enter Your Prompt"),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: controller,
                            cursorColor: Colors.deepPurple,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.deepPurple),
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 48,
                            width: double.maxFinite,
                            child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.deepPurple)),
                                onPressed: () {
                                  if (controller.text.isNotEmpty) {
                                    promptBloc.add(PromptEnteredEvent(
                                        prompt: controller.text));
                                  }
                                },
                                icon: Icon(Icons.generating_tokens),
                                label: Text('Generate')),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
