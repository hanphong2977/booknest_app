import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        title: Text('Hotel NYC', style: TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(5, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Row(
                                      children: [
                                        Text('${5 - index}',
                                            style: TextStyle(fontSize: 10)),
                                        SizedBox(width: 5),
                                        Expanded(
                                          child: LinearProgressIndicator(
                                            value: [
                                              0.6,
                                              0.3,
                                              0.2,
                                              0.1,
                                              0.05
                                            ][index],
                                            color: Color(0xFF60A5FA),
                                            backgroundColor: Colors.grey[300],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ]),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildComment('1 Thằng Đần nào đó', 5,
                    'Khách sạn phục vụ rất chu đáo và nhiệt tình, nhất là bạn lễ tân cười rất xinh! i want to marry her, and she will becoming the happiest bride in the world '),
                _buildComment('Khôi ngu', 4,
                    'Khách sạn tuyệt vời, nhưng thiếu trai đẹp nên tôi giảm bớt 1 sao!.'),
                _buildComment('Nguyễn Chí Bảo', 3,
                    'Tôi không thích đi du lịch, do tôi bị ép thôi, nên tôi muốn trút giận lên 1 ai đó :v.'),
                _buildComment('Nguyễn Chí Bảo', 3,
                    'Tôi không thích đi du lịch, do tôi bị ép thôi, nên tôi muốn trút giận lên 1 ai đó :v.'),
                _buildComment('Nguyễn Chí Bảo', 3,
                    'Tôi không thích đi du lịch, do tôi bị ép thôi, nên tôi muốn trút giận lên 1 ai đó :v.'),
                _buildComment('Nguyễn Chí Bảo', 3,
                    'Tôi không thích đi du lịch, do tôi bị ép thôi, nên tôi muốn trút giận lên 1 ai đó :v.'),
                _buildComment('Nguyễn Chí Bảo', 3,
                    'Tôi không thích đi du lịch, do tôi bị ép thôi, nên tôi muốn trút giận lên 1 ai đó :v.'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF60A5FA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text('Write Review', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComment(String name, int rating, String comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child: Image.asset(
                    'asset/images/avatar_male_image.png',
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/avatar_image.png',
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(comment),
          Divider(),
        ],
      ),
    );
  }
}
