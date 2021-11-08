//
//  PaymentContextDelegate.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 04/10/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation
import Stripe
import SwiftUI

class PaymentDelegate: NSObject, STPPaymentContextDelegate, ObservableObject {
    static let shared = PaymentDelegate()
    
    @Published var showAlert = false
    @Published var errorTitle: String? = nil
    @Published var errorMessage: String? = nil

    @Published var paymentLabel: String? = nil
    @Published var canPay: Bool = false
    @Published var icon: Image? = nil
    @Published var didPay: Bool = false
    @Published var paymentLoading : Bool = false

    var orderViewModel: OrderViewModel? = nil
    
    func setOrderViewModel(orderViewModel: OrderViewModel) {
        self.orderViewModel = orderViewModel
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        //   let title: String
        var message: String
        
        switch status {
        case .success:
            
            //    title = "Success!"
            message = "Thank you for your purchase."
            showAlert = true
            self.errorMessage = message
        case .error:
            
            //   title = "Error"
            message = error?.localizedDescription ?? ""
            showAlert = true
            self.errorMessage = message
        case .userCancellation:
            return
        @unknown default:
            fatalError("Something really bad happened....")
        }
    }
    
    
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        self.paymentLabel = paymentContext.selectedPaymentOption?.label
        self.canPay = paymentContext.selectedPaymentOption != nil
        if let image = paymentContext.selectedPaymentOption?.image {
            self.icon = Image(uiImage: image)
        }
        
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didUpdateShippingAddress address: STPAddress, completion: @escaping STPShippingMethodsCompletionBlock) {
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        
        guard let orderViewModel = orderViewModel else {
            completion(.error, nil)
            return
        }
        self.paymentLoading = true
        
        StripeAPIClient.shared.createPaymentIntent(order: orderViewModel.placeOrder()) { result in
            switch result {
            case .success(let clientSecret):
                // Assemble the PaymentIntent parameters
                let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret.clientSecret)
                paymentIntentParams.paymentMethodId = paymentResult.paymentMethod?.stripeId

                // Confirm the PaymentIntent
                STPPaymentHandler.shared().confirmPayment(withParams: paymentIntentParams, authenticationContext: paymentContext) { status, paymentIntent, error in
                    switch status {
                    case .succeeded:
                        // Your backend asynchronously fulfills the customer's order, e.g. via webhook
                        self.didPay = true
                        self.paymentLoading = false
                        completion(.success, nil)
                    case .failed:
                        self.errorTitle = "Erreur de paiement"
                        self.errorMessage = "Vous ne serez pas débité. Réessayez dans quelques instants."
                        completion(.error, error) // Report error
                    case .canceled:
                        self.errorTitle = "Annulé"
                        self.errorMessage = "Opération annulée par l'utilisateur. Vous ne serez pas débité."
                        completion(.userCancellation, nil) // Customer cancelled
                    @unknown default:
                        completion(.error, nil)
                    }
                }
            case .failure(let error):
                completion(.error, error) // Report error from your API
                break
            }
        }
    }
    
    func emptyErrorMessage() {
        errorMessage = nil
        errorTitle = nil
    }

}
