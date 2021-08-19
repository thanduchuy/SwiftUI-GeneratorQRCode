//
//  ContentViewModel.swift
//  QRApp
//
//  Created by than.duc.huy on 19/08/2021.
//
import CoreImage.CIFilterBuiltins
import SwiftUI
import Foundation
import Combine

struct ContentViewModel {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

extension ContentViewModel: BaseViewModel {
    struct Input {
        let contentQRText: AnyPublisher<String, Never>
    }

    struct Output {
        let qrData: AnyPublisher<UIImage, Never>
    }

    func bind(_ input: Input) -> Output {
        let qrData = input.contentQRText
            .map { generateQRCode(from: $0) }
            .eraseToAnyPublisher()

        return Output(qrData: qrData)
    }
}

