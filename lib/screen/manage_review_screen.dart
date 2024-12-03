import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1_admin/model/dolbom_review.dart';
import 'package:slost_only1_admin/provider/review_provider.dart';
import 'package:slost_only1_admin/support/server_response.dart';

class ManageReviewScreen extends StatefulWidget {
  const ManageReviewScreen({super.key});

  @override
  State<ManageReviewScreen> createState() => _ManageReviewScreenState();
}

class _ManageReviewScreenState extends State<ManageReviewScreen> {
  late ReviewProvider reviewProvider;

  int page = 0;

  @override
  void initState() {
    super.initState();
    reviewProvider = context.read<ReviewProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: reviewProvider.reportedList(page),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            PagedData<DolbomReview> data = snapshot.data!;
            if (data.numberOfElements == 0) {
              return const Center(child: Text("신고된 리뷰가 없습니다"),);
            }
            return ListView.builder(
                itemCount: data.numberOfElements,
                itemBuilder: (context, index) {
                  DolbomReview review = data.content[index];
                  return Row(
                    children: [
                      Text(review.star.toString()),
                      Text(review.content),
                      Text(review.reportReason.title),
                      Text(review.reportContent),
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Container();
          }
        });
  }
}
