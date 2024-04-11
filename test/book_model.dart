import 'package:flutter_test/flutter_test.dart';
import 'package:melbook/features/home/data/models/book.dart';

void main() {
  group("Book model", () {
    test("from json", () {
      final json = {
        "message": "Book fetched successfully",
        "status": 200,
        "data": [
          {
            "_id": "123",
            "name": "Book Name",
            "photo_url": "http://example.com/photo.jpg",
            "description": "Book Description",
            "author": "Author Name",
            "price": 20,
            "category": {
              "_id": "456",
              "name": "Category Name",
              "createdAt": "2022-04-09T12:00:00.000Z",
              "updatedAt": "2022-04-09T12:00:00.000Z",
              "__v": 0,
            },
            "book_url": "http://example.com/book.pdf",
            "createdAt": "2022-04-09T12:00:00.000Z",
            "updatedAt": "2022-04-09T12:00:00.000Z",
            "__v": 0,
            "bought": true,
            "audios": [
              {
                "_id": "789",
                "name": "Audio Name",
                "audio_url": "http://example.com/audio.mp3",
                "book_id": "123",
                "createdAt": "2022-04-09T12:00:00.000Z",
                "updatedAt": "2022-04-09T12:00:00.000Z",
                "__v": 0,
              }
            ]
          }
        ]
      };

      final book = Book.fromJson(json);

      print(book.data.first.name);
      print(book.data.first.description);
      print(book.data.first.author);
      expect(book, isA<Book>());
    });

    test("to json", () {
      final json = {
        "message": "Book fetched successfully",
        "status": 200,
        "data": [
          {
            "_id": "123",
            "name": "Book Name",
            "photo_url": "http://example.com/photo.jpg",
            "description": "Book Description",
            "author": "Author Name",
            "price": 20,
            "category": {
              "_id": "456",
              "name": "Category Name",
              "createdAt": "2022-04-09T12:00:00.000Z",
              "updatedAt": "2022-04-09T12:00:00.000Z",
              "__v": 0,
            },
            "book_url": "http://example.com/book.pdf",
            "createdAt": "2022-04-09T12:00:00.000Z",
            "updatedAt": "2022-04-09T12:00:00.000Z",
            "__v": 0,
            "bought": true,
            "audios": [
              {
                "_id": "789",
                "name": "Audio Name",
                "audio_url": "http://example.com/audio.mp3",
                "book_id": "123",
                "createdAt": "2022-04-09T12:00:00.000Z",
                "updatedAt": "2022-04-09T12:00:00.000Z",
                "__v": 0,
              }
            ]
          }
        ]
      };

      final book = Book.fromJson(json);
      final jsonString = book.toJson();
      print("jsonString: $jsonString");
      expect(jsonString, isA<String>());
    });
  });
}
