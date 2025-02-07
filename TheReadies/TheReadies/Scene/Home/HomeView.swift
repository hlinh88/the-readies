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
            }
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    Text("The Readies")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(SectionTitle.allCases, id: \.self) { section in
                        Section {
                            switch section {
                            case .ReadingNow:
                                ScrollView(.horizontal) {
                                    LazyHStack(spacing: 16) {
                                        HStack {
                                            Image(.bookCover)
                                                .resizable()
                                                .frame(width: 60, height: 80)
                                            
                                            VStack(alignment: .leading){
                                                Text("The Great Gatsby")
                                                    .font(.headline)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                
                                                Text("F. Scott Fitzgerald")
                                                    .font(.caption)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                
                                                ProgressView(value: 0.5, total: 1.0)
                                                    .progressViewStyle(.linear)
                                                    .tint(.white)
                                            }
                                            .frame(maxWidth: .infinity)
                                            
                                            Spacer()
                                        }
                                        .frame(width: 250, height: 100)
                                        .padding(.horizontal, 16)
                                        .background(
                                            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing)
                                                .cornerRadius(12)
                                        )
                                    }
                                }
                                
                            default: EmptyView()
                            }
                        } header: {
                            Text(section.title)
                                .font(.headline)
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
}

#Preview {
    HomeView()
}
