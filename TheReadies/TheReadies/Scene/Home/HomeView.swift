//
//  HomeView.swift
//  TheReadies
//
//  Created by Luke Nguyen on 7/2/25.
//

import SwiftUI

struct HomeView: View {
    enum SectionTitle: CaseIterable {
        case ReadingNow
        case Library
        case Author
        
        var title: String {
            switch self {
            case .ReadingNow:
                return "Reading Now"
            case .Library:
                return "Library"
            case .Author:
                return "Author"
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text("The Readies")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .opacity(0)
            }
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    Text("The Readies")
                        .bold()
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(SectionTitle.allCases, id: \.self) { section in
                        Section {
                            switch section {
                            case .ReadingNow:
                                ReadingNowView(books: READING_NOW_BOOKS)
                                
                            case .Library:
                                LibraryView()
                                
                            default: EmptyView()
                            }
                        } header: {
                            Text(section.title)
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                    }
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
//        .ignoresSafeArea(edges: .top)
    }
    
    struct ReadingNowView: View {
        let books: [Book]
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(books, id: \.id) { book in
                        HStack {
                            Image(.bookCover)
                                .resizable()
                                .frame(width: 60, height: 80)
                            
                            VStack(alignment: .leading){
                                Text(book.title)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text(book.author)
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                ProgressView(value: 0.5, total: 1.0)
                                    .progressViewStyle(.linear)
                                    .tint(.white)
                            }
                            .frame(maxWidth: .infinity)
                            
                            Spacer()
                        }
                        .frame(width: 250, height: 120)
                        .padding(.horizontal, 16)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing)
                                .cornerRadius(20)
                        )
                    }
                }
            }
        }
    }
    
    struct LibraryView: View {
        var body: some View {
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "books.vertical.fill")
                    Text("Library")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("3")
                    Image(systemName: "chevron.right")
                }
                
                HStack {
                    Image(systemName: "book.fill")
                    Text("Reading")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("3")
                    Image(systemName: "chevron.right")
                }
                
                HStack {
                    Image(systemName: "bookmark.fill")
                    Text("To Read")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("3")
                    Image(systemName: "chevron.right")
                }
                
                HStack {
                    Image(systemName: "checkmark.seal.fill")
                    Text("Finished")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("3")
                    Image(systemName: "chevron.right")
                }
            }
            .cornerRadius(20)
            .padding(16)
            .background(Color.gray.opacity(0.1))
        }
    }
}

#Preview {
    HomeView()
}
