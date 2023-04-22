//
//  CaptureImage.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/22/23.
//

import SwiftUI

struct CaptureImage: View {
    var capturedImage: UIImage?
    var plantName: String?
    
    var body: some View {
        VStack {
            Image(uiImage: capturedImage ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            Text(plantName ?? "")
        }
    }
}

struct CaptureImage_Previews: PreviewProvider {
    static var previews: some View {
        CaptureImage()
    }
}
