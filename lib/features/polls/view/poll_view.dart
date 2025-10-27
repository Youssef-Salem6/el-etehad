import 'package:el_etehad/features/home/view/widgets/voting_component.dart';
import 'package:el_etehad/features/polls/manager/cubit/get_all_polls_cubit.dart';
import 'package:el_etehad/features/polls/model/polls_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PollView extends StatefulWidget {
  const PollView({super.key});

  @override
  State<PollView> createState() => _PollViewState();
}

class _PollViewState extends State<PollView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetAllPollsCubit>(context).getAllPolls();
  }

  // Convert API model to Poll widget model with automatic color assignment
  Poll convertToPoll(PollsModel pollModel) {
    List<PollOption> pollOptions = [];

    if (pollModel.options != null) {
      for (int i = 0; i < pollModel.options!.length; i++) {
        final optionData = pollModel.options![i];

        // Automatically assign color based on index
        final color = PollColorGenerator.getColorForIndex(i);

        pollOptions.add(
          PollOption(
            color: color,
            text: optionData['option_text'] ?? '',
            votes: optionData['votes'] ?? 0,
          ),
        );
      }
    }

    return Poll(
      question: pollModel.title ?? '',
      options: pollOptions,
      totalVotes: pollModel.totaVotes ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("استطلاعات رأي"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetAllPollsCubit, GetAllPollsState>(
          builder: (context, state) {
            if (state is GetAllPollsLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('جاري تحميل الاستطلاعات...'),
                  ],
                ),
              );
            }

            if (state is GetAllPollsFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'فشل في تحميل الاستطلاعات',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'يرجى التحقق من اتصال الإنترنت',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        BlocProvider.of<GetAllPollsCubit>(
                          context,
                        ).getAllPolls();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('إعادة المحاولة'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            List polls = BlocProvider.of<GetAllPollsCubit>(context).polls;

            if (polls.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.poll_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'لا توجد استطلاعات متاحة حالياً',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                await BlocProvider.of<GetAllPollsCubit>(context).getAllPolls();
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: polls.length,
                itemBuilder: (context, index) {
                  // Convert Map to PollsModel
                  final pollModel = PollsModel.fromJson(json: polls[index]);

                  // Convert PollsModel to Poll widget model with colors
                  final poll = convertToPoll(pollModel);

                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedPollWidget(
                        poll: poll,
                        pollsModel: pollModel,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
