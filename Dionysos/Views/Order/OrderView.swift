//
//  OrderView.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 12/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI
import Stripe

struct OrderView: View {
    @EnvironmentObject var orderViewModel: OrderViewModel
    @EnvironmentObject var accountViewModel: AccountViewModel
    
    @ObservedObject var paymentDelegate = PaymentDelegate.shared
    
    let config = STPPaymentConfiguration.shared()
    var paymentContext: STPPaymentContext
    
    @State var paymentLoading: Bool = false
    @State var paymentSuccess: Bool = false
    
    @State var alertShouldBePresented: Bool = false

    init() {
        self.paymentContext = STPPaymentContext(customerContext: StripeContext.sharedCustomerContext)
        self.paymentContext.delegate = paymentDelegate
        
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        self.paymentContext.hostViewController = keyWindow?.rootViewController
        self.config.requiredBillingAddressFields = .none
    }
    
    
    var body: some View {
        DispatchQueue.main.async {
            paymentLoading = paymentDelegate.paymentLoading
            paymentSuccess = paymentDelegate.didPay
            if paymentSuccess {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    paymentDelegate.didPay.toggle()
                }
            }
            if paymentDelegate.errorTitle != nil {
                paymentLoading = false
                alertShouldBePresented = true
            } else {
                alertShouldBePresented = false
            }
        }
        return ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Image("Order 1")
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20.0) {
                RestaurantHeader(orderViewModel: orderViewModel)
                
                VStack(spacing: 10.0) {
                        HStack {
                            Text("Ma commande").font(.system(size: 32, weight: .bold))
                                .foregroundColor(Color("Primary 1"))
                            Spacer()
                            AvatarIconButton()
                                .environmentObject(accountViewModel)

                        }.padding(.trailing, 6.0)
                    if orderViewModel.productCount > 0 {
                        List {
                            ForEach(orderViewModel.order.compactMap({
                                $0.value
                            }).sorted(by: {
                                $0.name < $1.name
                            }), id: \.id) { food in
                                OrderFoodRow(food: food).onTapGesture {
                                    self.orderViewModel.selectFood(food: food)
                                }
                            }
                            .listRowBackground(Color("Background"))
                        }
                        Spacer()
                        VStack(spacing: 18.0) {
                            VStack(spacing: 0) {
                                Text("\(orderViewModel.productCount) articles")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(Color("Secondary 1"))
                                    .multilineTextAlignment(.center)
                                
                                //Total : 40,00 €
                                Text("Total : \(String(format: "%.2f", orderViewModel.total)) €")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(Color("Secondary 1"))
                                    .multilineTextAlignment(.center)
                            }
                            
                            Button(action: {self.paymentContext.presentPaymentOptionsViewController()}, label: {
                                ZStack {
                                    HStack(spacing: 12.0) {
                                        //Pay with
                                        paymentDelegate.icon?.resizable().aspectRatio(contentMode: .fit).frame(width: 32.0)
                                        Text("\(paymentDelegate.paymentLabel ?? "Choisissez une méthode de paiement")")
                                            .font(.system(size: 15, weight: .regular))
                                            .foregroundColor(Color("Primary 1"))
                                            .multilineTextAlignment(.center)
                                            .lineLimit(nil)
                                        
                                    }.frame(width: 300, height: 44)
                                    .background(RoundedRectangle(cornerRadius: 6)
                                                    .fill(Color("Secondary 1"))
                                                
                                    )
                                }
                            }).shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:20, x:0, y:10)

                            
                            Button(action: {
                                self.paymentLoading = true
                                self.paymentDelegate.setOrderViewModel(orderViewModel: orderViewModel)
                                self.paymentContext.requestPayment()
                                
                            }, label: {
                                ZStack {
                                    
                                    HStack {
                                        //Pay with
                                        Text("Payer").font(.system(size: 20, weight: .medium)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).multilineTextAlignment(.center)
                                    }.frame(width: 300, height: 44)
                                    .background(RoundedRectangle(cornerRadius: 6)
                                                    .fill(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                                
                                    )
                                }
                            }).shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:20, x:0, y:10)
                        }
                    }
                    
                    else {
                        Text("Votre commande est vide.\nVous pouvez ajouter des articles à votre commande en consultant la carte du restaurant.\nN’oubliez pas de vous inscrire à Dionysos pour pouvoir commander et suivre vos commandes.")
                            .font(.system(size: 17, weight: .regular))
                            .padding(.horizontal, 8.0)

                        Spacer()
                            Text("Aucun article dans la commande")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Color("Secondary 1"))
                                .multilineTextAlignment(.center)
                                .frame(width: 192, height: 87)
                                .padding(.bottom, 60.0)
                    }
                }
            }.padding(.horizontal, 12.0)
            
            
            ModifyOrderCard(orderViewModel: orderViewModel)
            
            if paymentLoading {
                Color("Primary 1")
                    .opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                LottieView(name: "PaymentLoading")
                    .frame(width: 280)
                    .edgesIgnoringSafeArea(.all)
                
            }
            
            if paymentSuccess {
                Circle()
                    .fill(Color("Gray 4"))
                    .frame(width: 280, height: 280)
                LottieView(name: "PaymentSucceeded", loopMode: .loop)
                    .frame(width: 256, height: 256)
                    .edgesIgnoringSafeArea(.all)
                
            }
            
            
        }
        .navigationBarTitle("")
        .onAppear {
            self.paymentContext.paymentAmount = orderViewModel.stripeTotal
            self.paymentDelegate.setOrderViewModel(orderViewModel: orderViewModel)
        }
        .alert(isPresented: $alertShouldBePresented) {
            Alert(title: Text(paymentDelegate.errorTitle ?? "Erreur"), message: Text(paymentDelegate.errorMessage ?? "Erreur inconnue. Réessayez dans quelques instants."), dismissButton: .default(Text("D'accord"), action: {
                paymentDelegate.emptyErrorMessage()
            }))
        }
        
    }
}

#if DEBUG
struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = OrderViewModel(restaurant: restaurant, table: table)
        viewModel.addFoodToOrder(food: sexOnTheBeach)
        viewModel.addFoodToOrder(food: caipirinha)
        viewModel.addFoodToOrder(food: caipirinha)
        viewModel.addFoodToOrder(food: cosmopolitain)
        return OrderView().environmentObject(viewModel)
    }
}
#endif
