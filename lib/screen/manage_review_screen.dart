import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
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

  static const double _profileImageWidth = 150;
  static const double _columnWidth = 200;

  @override
  void initState() {
    super.initState();
    reviewProvider = context.read<ReviewProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: _columnWidth + 16,
                child: Text("평점"),
              ),
              SizedBox(
                width: _columnWidth + 16,
                child: Text("내용"),
              ),
              SizedBox(
                width: _columnWidth + 16,
                child: Text("신고 사유"),
              ),
              SizedBox(
                width: _columnWidth + 16,
                child: Text("신고 내용"),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: FutureBuilder(
                future: reviewProvider.reportedList(page),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    PagedData<DolbomReview> data = snapshot.data!;
                    if (data.numberOfElements == 0) {
                      return const Center(
                        child: Text("신고된 리뷰가 없습니다"),
                      );
                    }
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: data.numberOfElements,
                          itemBuilder: (context, index) {
                            DolbomReview review = data.content[index];
                            return DropdownButton2(
                              customButton: SizedBox(
                                height: 56,
                                child: Row(
                                  children: [
                                    ColumnBox(
                                        child: Text(
                                            (review.star / 10).toString())),
                                    ColumnBox(child: Text(review.content)),
                                    ColumnBox(
                                        child: Text(review.reportReason.title)),
                                    ColumnBox(
                                        child:
                                            Text(review.reportContent ?? "-")),
                                  ],
                                ),
                              ),
                              dropdownStyleData:
                                  const DropdownStyleData(width: 160),
                              items: [
                                DropdownMenuItem(
                                  child: const Text("삭제"),
                                  onTap: () {
                                    reviewProvider.delete(review.id).then((_) {
                                      setState(() {});
                                    }).catchError((e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(e.toString())));
                                    });
                                  },
                                )
                              ],
                              onChanged: (value) {},
                            );
                          }),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return Container();
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class ColumnBox extends StatelessWidget {
  const ColumnBox({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: _ManageReviewScreenState._columnWidth,
      child: child,
    );
  }
}
