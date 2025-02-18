//
//  BookView.swift
//  TheReadies
//
//  Created by Luke Nguyen on 18/2/25.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct BookView: View {
    let book: Book
    
    @State private var dominantColors: [Color] = []
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: dominantColors),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    Button(action: {
                        print("Back button tapped")
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                            
                            Text("Back")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                    
                }
                .frame(height: 32)
                .padding(.horizontal, 16)
                .overlay(
                    Text(book.title)
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .frame(maxWidth: 150),
                    alignment: .center
                )
                
                ScrollView {
                    VStack {
                        Image(.bookCover)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 300)
                            .shadow(radius: 10)
                            .onAppear {
                                extractDominantColors()
                            }
                        
                        Text(book.title)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                    }
                    .padding(.top, 50)
                }
                
                
                Spacer()
            }
            
        }
        .toolbar(.hidden)
    }
    
    // Function to extract dominant colors
    private func extractDominantColors() {
        guard let uiImage = UIImage(named: "book_cover") else { return }
        let ciImage = CIImage(image: uiImage)
        let filter = CIFilter.kMeans()
        filter.inputImage = ciImage
        filter.count = 3 // Extract three dominant colors
        
        let context = CIContext()
        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiOutputImage = UIImage(cgImage: cgImage)
            let colors = extractColors(from: uiOutputImage)
            DispatchQueue.main.async {
                self.dominantColors = colors
            }
        }
    }
    
    // Function to convert UIImage colors to SwiftUI Colors
    private func extractColors(from image: UIImage) -> [Color] {
        guard let cgImage = image.cgImage else { return [Color.blue, Color.purple] }
        
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8
        
        var pixelData = [UInt8](repeating: 0, count: width * height * bytesPerPixel)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(
            data: &pixelData,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )
        
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        var colorCounts: [UIColor: Int] = [:]
        
        for x in 0..<width {
            for y in 0..<height {
                let pixelIndex = (y * width + x) * bytesPerPixel
                let r = CGFloat(pixelData[pixelIndex]) / 255.0
                let g = CGFloat(pixelData[pixelIndex + 1]) / 255.0
                let b = CGFloat(pixelData[pixelIndex + 2]) / 255.0
                let color = UIColor(red: r, green: g, blue: b, alpha: 1)
                
                colorCounts[color, default: 0] += 1
            }
        }
        
        let sortedColors = colorCounts.sorted { $0.value > $1.value }.prefix(3).map { Color($0.key) }
        return sortedColors.isEmpty ? [Color.blue, Color.purple] : sortedColors
    }
}

#Preview {
    BookView(book: READING_NOW_BOOKS[0])
}
