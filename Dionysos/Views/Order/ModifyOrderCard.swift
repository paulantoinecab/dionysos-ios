//
//  ModifyOrderCard.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 12/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

import SwiftUI

public struct Positions {
    public static var high: CGSize {
        CGSize(width: 0.0, height: UIScreen.screenHeight - 150 - (343 + 20))
    }
    public static var down: CGSize {
        CGSize(width: 0.0, height: UIScreen.screenHeight)
    }
    
}

struct ModifyOrderCard: View {
    @ObservedObject var orderViewModel: OrderViewModel
    @State private var draggedOffset = Positions.down
    
    var body: some View {
        let food = orderViewModel.selectedFood
        DispatchQueue.main.async {
            if food != nil {
                self.draggedOffset = Positions.high
            } else {
                self.draggedOffset = Positions.down
            }
        }
        return ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .light))
                .edgesIgnoringSafeArea(.all)

            
            VStack(spacing: 8.0) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color("Primary 3"))
                    .frame(width: 50.0, height: 4.0)
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:5, x:0, y:2.5)
                    
                    .onTapGesture {
                        self.orderViewModel.unselectFood()
                    }
                VStack(spacing: 20.0) {
                    if food != nil {
                        NavigationLink(
                            destination: FoodDetailView(food: food!)
                                .environmentObject(orderViewModel)) {
                            HStack(spacing: 12.0) {
                                URLImage(url: food!.image, blurHash: food?.imageHash)
                                    .frame(width: 60, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                VStack(alignment: .leading, spacing: 0) {
                                    //Sex On The Beach
                                    Text(food!.name)
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(Color("Primary 3"))
                                    
                                    //Le Sex on the beach est un...
                                    Text(food!.foodDescription)
                                        .foregroundColor(.black)
                                        .font(.system(size: 12, weight: .regular))
                                }
                                
                                VStack {
                                    Text("\(String(format: "%.2f", food!.price))€")
                                        .font(.system(size: 16, weight: .light))
                                        .foregroundColor(Color("Primary 3"))
                                        .multilineTextAlignment(.trailing)
                                    Spacer()
                                }
                                
                            }
                            .padding(.horizontal, 29.0)
                            .frame(height: 66.0)
                        }
                        HStack(spacing: 4.0) {//x 1
                            Button(action: {
                                self.orderViewModel.decrementSelectedFood()
                                
                            }) {
                                
                                Image("MinusIcon")
                                    .resizable()
                                    .colorMultiply(Color("Primary 3"))
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: 32.0, height: 32.0)
                            
                            Text("x \(food!.quantity)")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(Color("Primary 3"))
                                .multilineTextAlignment(.center)
                            Button(action: {
                                self.orderViewModel.incrementSelectedFood()
                            }) {
                                Image("PlusIcon")
                                    .resizable()
                                    .colorMultiply(Color("Primary 3"))
                                
                            }
                            .frame(width: 32.0, height: 32.0)
                            
                        }
                        .padding(.top, 16.0)
                        
                        //10 €
                        Text("\(String(format: "%.2f", orderViewModel.sumForFood))€")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(Color("Primary 3"))
                            .multilineTextAlignment(.center)
                            .padding(.top, 4.0)
                        VStack(alignment: .center, spacing: 12.0) {
                            Button(action: {
                                self.orderViewModel.unselectFood()
                            }) {
                                ZStack {
                                    //Rectangle 17
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color("Secondary 1"))
                                        .frame(width: 341, height: 44)
                                    
                                    //Valider
                                    Text("Valider")
                                        .font(.system(size: 15, weight: .regular))
                                        .foregroundColor(Color("Primary 1"))
                                        .multilineTextAlignment(.center)
                                    
                                }
                            }
                            Button(action: {
                                self.orderViewModel.removeSelectedFoodFromOrder()
                            }) {
                                ZStack {
                                    //Rectangle 18
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color("Primary 1"))
                                        .frame(width: 341, height: 44)
                                    
                                    //Retirer de la commande
                                    Text("Retirer de la commande")
                                        .font(.system(size: 18, weight: .regular))
                                        .foregroundColor(Color("Secondary 1"))
                                        .multilineTextAlignment(.center)
                                }
                            }
                        }
                        .padding(.top, 18.0)
                    } else {
                        Spacer()
                        //Aucun item sélectionné
                        Text("Aucun item sélectionné")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(Color("Primary 3"))
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }
                
                Spacer()
            }.padding(.top, 12.0)
            
            
            
        }
        .clipped()
        .frame(width: 375, height: 643)
        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25)), radius:30, x:0, y:-15)
        .background(RoundedRectangle(cornerRadius: 16)
                        .fill(Color(#colorLiteral(red: 0.9791666865, green: 0.9661111236, blue: 0.9546875358, alpha: 0.6)))
                        )
        .gesture(DragGesture()
                    .onChanged({value in
                        self.draggedOffset = CGSize(width: 0.0, height: value.translation.height)
                    })
                    .onEnded({value in
                        if value.translation.height > 0 {
                            self.orderViewModel.unselectFood()
                        }
                    })
        )
        .onTapGesture {
            if(self.draggedOffset.height) == Positions.down.height {
                self.draggedOffset = Positions.high
            }
        }
        
        .animation(.spring())
        .offset(y: self.draggedOffset.height)
        
        
    }
}

#if DEBUG
struct ModifyOrderCard_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = OrderViewModel(restaurant: restaurant, table: table)
        viewModel.addFoodToOrder(food: sexOnTheBeach)
        viewModel.addFoodToOrder(food: caipirinha)
        viewModel.addFoodToOrder(food: caipirinha)
        viewModel.addFoodToOrder(food: cosmopolitain)
        return ModifyOrderCard(orderViewModel: viewModel)
    }
}
#endif
