//
//  QRCodeScannerView.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 16/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

struct ScannerView: View {
    @EnvironmentObject var accountViewModel: AccountViewModel
    
    @ObservedObject var viewModel = QRCodeScannerViewModel()
    @State var shouldPush: Bool = false
    @State var alertShouldBePresented: Bool = false
    @State private var destID = 0
    
    private let scannerView: QRCodeScannerView = QRCodeScannerView()
    
    init() {
    }
    
    
    var body: some View {
        DispatchQueue.main.async {
            shouldPush = viewModel.shouldPush && (self.viewModel.orderViewModel != nil)
            alertShouldBePresented = (viewModel.errorTitle != nil)
        }
        return ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            ZStack {
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        Image("Scanner 2")
                            .scaleEffect(1.3)
                    }
                }

                VStack {
                    Spacer()
                    HStack {
                        Image("Scanner 1")
                            .scaleEffect(1.3)
                        Spacer()
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .blur(radius: 30.0)
            
            
            
            VStack(spacing: 0.0) {
                //Scannez le code Dionysos p...
                Text("Scannez le code Dionysos présent sur la table à l’aide de l’appareil photo.")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.black)
                    .padding(.leading, 21.0)
                    .padding(.trailing, 12.0)
                if viewModel.orderViewModel != nil {
                    NavigationLink(destination: RestaurantRootView(orderViewModel: self.viewModel.orderViewModel!)
                                    .environmentObject(accountViewModel)
                                    .environmentObject(viewModel), isActive: self.$shouldPush) {
                        EmptyView()
                    }
                }
                
                ZStack {
                    scannerView
                        .found(r: self.viewModel.onFoundQrCode)
                        .torchLight(isOn: self.viewModel.torchIsOn)
                        .interval(delay: self.viewModel.scanInterval)
                        .cornerRadius(8.0)
                        .frame(height: 396.0)
                        .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.25), radius: 15, x: 0.0, y: 15.0)
                    
                    LottieView(name: "QRCodeScanner")
                        .frame(width: 200.0, height: 200.0)
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                self.viewModel.torchIsOn.toggle()
                            }, label: {
                                Image(systemName: self.viewModel.torchIsOn ? "bolt.fill" : "bolt.slash.fill")
                                    .imageScale(.large)
                                    .foregroundColor(self.viewModel.torchIsOn ? Color.yellow : Color("Text 1"))
                                    .padding()
                            })
                            
                        }
                        .cornerRadius(10)
                        .padding(.trailing, 12.0)
                        Spacer()
                    }
                }
                .frame(height: 396.0)
                .padding(.horizontal, 38.0)
                .padding(.top, 30.0)
                Spacer()
            }
            
        }
        .onDisappear {
            QRCodeScannerView.dismantleUIView(scannerView, coordinator: ())
        }
        .alert(isPresented: $alertShouldBePresented) {
            Alert(title: Text(viewModel.errorTitle ?? "Erreur"), message: Text(viewModel.errorMessage ?? "Erreur inconnue. Réessayez dans quelques instants."), dismissButton: .default(Text("D'accord"), action: {
                viewModel.emptyErrorMessage()
            }))
        }
        .navigationBarTitle("À Table")
        .accentColor(Color("Primary 1"))
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView().environmentObject(AccountViewModel())
    }
}
