//
//  QRCodeScannerViewModel.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 16/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import Foundation
class QRCodeScannerViewModel: ObservableObject {
    
    /// Defines how often we are going to try looking for a new QR-code in the camera feed.
    let scanInterval: Double = 1.0
    
    @Published var torchIsOn: Bool = false
    @Published var shouldPush: Bool = false
    @Published var orderViewModel: OrderViewModel? = nil
    @Published var errorMessage: String? = nil
    @Published var errorTitle: String? = nil

    func onFoundQrCode(_ code: String) {
        let regex = "https:\\/\\/dionysos.fr\\/api\\/table\\/[0-9a-fA-F]{8}\\-[0-9a-fA-F]{4}\\-[0-9a-fA-F]{4}\\-[0-9a-fA-F]{4}\\-[0-9a-fA-F]{12}"

        if code ~= regex {
            let url = code.split(separator: "/")

            guard url.count == 5 else { return }
            let tableId = String(url[4])
            
            loadTableRestaurant(tableId: tableId)
        }
    }
    
    func loadTableRestaurant(tableId: String) {
        #if DEBUG
        self.orderViewModel = OrderViewModel(restaurant: restaurant, table: table)
        self.shouldPush = true

        #else

        SitToTableService.shared.fetchTableRestaurant(tableId: tableId) { (result) in
            do {
                let tableRestaurant = try result.get()
                DispatchQueue.main.async {
                    self.orderViewModel = OrderViewModel(restaurant: tableRestaurant.restaurant, table: tableRestaurant.table)
                    self.shouldPush = true
                }
            }
            catch SitToTableService.APIServiceError.notFound {
                DispatchQueue.main.async {
                    self.errorTitle = "Table non trouvée"
                    self.errorMessage = "Le code que vous avez scanné ne correspond à aucune table. Essayez de rescanner le QR Code."
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorTitle = "Erreur"
                   self.errorMessage = "Erreur inconnue. Réessayez dans quelques instants."
                }
            }
        }
        #endif

    }
    
    
    func emptyErrorMessage() {
        DispatchQueue.main.async {
            self.errorTitle =  nil
           self.errorMessage = nil
        }
    }

    func leaveRestaurant() {
        self.orderViewModel = nil
        self.shouldPush = false
    }
}
