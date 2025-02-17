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
//        case Author
        
        var title: String {
            switch self {
            case .ReadingNow:
                return "Reading Now"
            case .Library:
                return "Library"
//            case .Author:
//                return "Author"
            }
        }
    }
    
    @State private var threshold: CGFloat?
    @State private var shouldShowFloatingTitle = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack {
                Text("The Readies")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .opacity(shouldShowFloatingTitle ? 1 : 0)
                
                Spacer()
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.2))
                    .opacity(shouldShowFloatingTitle ? 1 : 0)
            }
            .frame(height: 32)
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    Text("The Readies")
                        .bold()
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .background(GeometryReader { geometry in
                            let minY = geometry.frame(in: .global).minY
                            
                            SwiftUI.Color.clear
                                .onAppear {
                                    if threshold == nil {
                                        threshold = minY - geometry.size.height
                                    }
                                }
                                .onChange(of: minY) { _, newValue in
                                    withAnimation {
                                        if let threshold {
                                            shouldShowFloatingTitle = newValue < threshold
                                        }
                                    }
                                }
                        })
                    
                    ForEach(SectionTitle.allCases, id: \.self) { section in
                        Section {
                            switch section {
                            case .ReadingNow:
                                ReadingNowView(books: READING_NOW_BOOKS)
                                    .padding(.leading, 16)
                                
                            case .Library:
                                LibraryView()
                                    .padding(.horizontal, 16)
                            }
                        } header: {
                            Text(section.title)
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 16)
                        }

                    }
                }
            }
            
            Spacer()
        }
        .background(.homeBackground)
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
        let items: [LibraryItem] = [
            .init(image: "books.vertical.fill", title: "Library", count: 3),
            .init(image: "book.fill", title: "Reading", count: 3),
            .init(image: "bookmark.fill", title: "To Read", count: 3),
            .init(image: "checkmark.seal.fill", title: "Finished", count: 3)
        ]
        var body: some View {
            VStack(spacing: 16) {
                ForEach(items, id: \.id) { item in
                    LibraryItemView(item: item)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
    
    struct LibraryItemView: View {
        let item: LibraryItem
        
        var body: some View {
            HStack {
                Image(systemName: item.image)
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Text(item.title)
                    .font(.headline)
                
                Spacer()
                
                Text("\(item.count)")
                Image(systemName: "chevron.right")
            }
            .padding(.vertical, 4)
//            .overlay(
//                Rectangle()
//                    .frame(height: 1)
//                    .foregroundColor(Color.gray.opacity(0.1)),
//                alignment: .bottom
//            )
        }
    }
}

#Preview {
    HomeView()
}
