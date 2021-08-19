//
//  ContentView.swift
//  QRApp
//
//  Created by than.duc.huy on 19/08/2021.
//

import SwiftUI

enum Constants {
    static let spacingTopView: CGFloat = 100
    static let detailQRPlaceHolder = "Enter content QRCODE"
}

struct ContentView: View {
    @SubjectBinding private var contentTextView = ""
    @State private var imageQR = UIImage()
    var viewModel: ContentViewModel
    var output: ContentViewModel.Output

    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
        let input = ContentViewModel.Input(contentQRText: _contentTextView.anyPublisher())
        self.output = viewModel.bind(input)
    }


    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Spacer()
                }
                .background(
                    Image("background")
                        .resizable()
                        .scaledToFill()
                )

                VStack {
                    HStack {
                        Spacer()
                        Image(uiImage: imageQR)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.height * 0.4,
                                   height: geometry.size.height * 0.4)
                            .shadow(radius: 10)
                            .border(Color.black, width: 4)
                        Spacer()
                    }
                    .padding(.bottom, Constants.spacingTopView)

                    TextField(Constants.detailQRPlaceHolder, text: $contentTextView)
                                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                            .background(Color.white)
                                            .padding(.horizontal, 16)
                                            .background(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .fill(Color.white)
                                                    .shadow(color: Color.black, radius: 2, x: 0, y: 2)
                                            )
                                            .padding(.all, 8)

                    Spacer()
                }
                .padding(.top, Constants.spacingTopView)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .onReceive(output.qrData) {
            imageQR = $0
        }
        .animation(.default)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
