//
//  MockData.swift
//  TheReadies
//
//  Created by Luke Nguyen on 10/2/25.
//

struct Book: Codable {
    var id: Int
    var image: String
    var title: String
    var author: String
    
    init(image: String, title: String, author: String) {
        self.image = image
        self.title = title
        self.id = title.hashValue
        self.author = author
    }
}

let READING_NOW_BOOKS: [Book] = [.init(
    image: "",
    title: "The Great Gatsby",
    author: "F. Scott Fitzgerald"
), .init(
    image: "",
    title: "To Kill a Mockingbird",
    author: "Harper Lee"
)]

struct LibraryItem: Codable {
    var id: Int
    var image: String
    var title: String
    var count: Int
    
    init(image: String, title: String, count: Int) {
        self.image = image
        self.title = title
        self.id = title.hashValue
        self.count = count
    }
}
