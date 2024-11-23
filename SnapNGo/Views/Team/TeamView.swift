//
//  TeamView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/1.
//

import SwiftUI
import CodeScanner

struct TeamView: View {
    
    @State private var isShowingScanner = false

    var body: some View {
        VStack(alignment: .center){
            Image(Constants.TeamViewConstant.teamHomeImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 8)
            Text(Constants.TeamViewConstant.welcomeMessage)
                .fontWeight(.semibold)
                .padding(.bottom, 8)
                .frame(maxWidth: 300)
                .lineLimit(2)
                .multilineTextAlignment(.center)
            Text(Constants.TeamViewConstant.description)
                .frame(width: 280)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .fontWeight(.light)
                .padding(.bottom, 8)
            Button(action: scanQRcode) {
                Text(Constants.TeamViewConstant.joinButtonText)
                    .frame(width: 300)
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "https://www.google.com", completion: handleScan)
        }
    }
    
    func scanQRcode() {
        isShowingScanner = true
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            //MARK: - Default open the link, Change to join team after scanning using navigation
            if let url = URL(string: result.string) {
                // Open the link in the browser
                UIApplication.shared.open(url, options: [:]) { success in
                    if success {
                        print("Opened \(url) successfully")
                    } else {
                        print("Failed to open \(url)")
                    }
                }
            } else {
                print("Invalid URL: \(result.string)")
            }
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    TeamView()
}
