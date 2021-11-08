//
//  Mocks.swift
//  Dionysos
//
//  Created by Paul-Antoine Cabrera on 10/08/2020.
//  Copyright © 2020 Paul-Antoine Cabrera. All rights reserved.
//

#if DEBUG
import Foundation

let mojito = Food(id: UUID(), name: "Mojito", price: 10.0, ingredients: "Rhum blanc,eau gazeuse, menthe, sucre de canne, citron vert", foodDescription: "Un classique de la Madone.  Le mojito, prononcé [moˈxito] en espagnol, ou mojito, morito, ou mohito en français, est un cocktail traditionnel de la cuisine cubaine et de la culture de Cuba, à base de rhum, de soda, de citron vert, et de feuilles de menthe fraîche. Inspiré du mint julep, et variante des Ti-punch des Antilles, Daïquiri, et Cuba libre, il est né à Cuba dans les Caraïbes dans les années 1910 (dont il est à ce jour un emblème exotique international).", image: "", imageHash: "UNE{2:O[-pN{0JE1RPx]-;ogs:V?NGbFs.W=", order: 0)
let sexOnTheBeach = Food(id: UUID(), name: "Sex On The Beach", price: 10.0, ingredients: "Rhum blanc, eau gazeuse, menthe, sucre de canne, citron vert", foodDescription: "Le Sex on the beach est un cocktail alcoolisé créé par le T.G.I. Friday's.", image: "", imageHash: "UNE{2:O[-pM{1SE1RPx]-;ogs:V?NGbFs.W=", order:1)
let margarita = Food(id: UUID(), name: "Margarita", price: 10.0, ingredients: "", foodDescription: "", image: "", imageHash: "UNE{2:O[-pM{0JE1RPx]-;ogs:V?NZcFs.W=", order:2)
let caipirinha = Food(id: UUID(), name: "Caïpirinha", price: 10.0, ingredients: "Rhum blanc,eau gazeuse, menthe, sucre de canne, citron vert", foodDescription: "La caïpirinha est un cocktail brésilien préparé à base de cachaça, de sucre de canne et de citron vert.", image: "", imageHash: "UN1{2:2[-pM{0DE1RPx]-;ogs:V?NGbFs.W=", order:3)
let cosmopolitain = Food(id: UUID(), name: "Cosmopolitain", price: 10.0, ingredients: "", foodDescription: "Le Cosmopolitan est un cocktail de couleur rose, classique des cocktail officiel de l'IBA, à base de vodka, de triple sec, de citron vert, et de jus de canneberge.", image: "", imageHash: "UNE{2:O[-sX{0JE1RPx]-;ogs:V?NGbFs.W=", order: 4)
let americano = Food(id: UUID(), name: "Americano", price: 10.0, ingredients: "", foodDescription: "L'Americano est un cocktail à base de campari, de vermouth rouge doux et de club soda.", image: "", imageHash: "UNE{2:O[-pM{0JE1RPx]-;ogs:V?N4dFs.W=", order: 5)

let cocktailsDuMoment = FoodSection(id: UUID(), name: "Cocktails du moment", food: [sexOnTheBeach, caipirinha, cosmopolitain], order: 0)
let lesClassiques = FoodSection(id: UUID(), name: "Les classiques", food: [americano, caipirinha], order: 1)

let cocktails = Category(id: UUID(), name: "Cocktails", image: "", imageHash: "UNE{2:O[-cM}0JE1RPx]-;css:2?NGbFs.W=", headers: [mojito, margarita], foodSections: [cocktailsDuMoment, lesClassiques], order: 0)
let planches = Category(id: UUID(), name: "Planches", image: "", imageHash: "UNE{2:O[-cM}0JE1RPx]-;ogs:V?NGbFs.W=", headers: [], foodSections: [], order: 1)
let bieres = Category(id: UUID(), name: "Bieres", image: "", imageHash: "UNE{2:O[-pM{0DG1RPx]-;ogs:V?NGbFs.W=", headers: [], foodSections: [], order: 2)
let soft = Category(id: UUID(), name: "Soft Drinks", image: "", imageHash: "UNE{1:3[-pM{0JE1RPx]-;ogs:V?NGbFs.W=", headers: [], foodSections: [], order: 3)
let poulets = Category(id: UUID(), name: "Poulets", image: "", imageHash: "UNE{2:O[-pX{0JE1RPx]-;ogs:V?NGbFs.W=", headers: [], foodSections: [], order: 4)
let encas = Category(id: UUID(), name: "En cas", image: "", imageHash: "UNE{2:O[-gM{0JE2SPx]-;ogs:V?NGbFs.W=", headers: [], foodSections: [], order: 6)


let aLaUne = Section(id: UUID(), name: "À La Une", categories: [cocktails, planches], order: 0)
let boissons = Section(id: UUID(), name: "Boissons", categories: [bieres, soft], order: 1)
let nourriture = Section(id: UUID(), name: "Nourriture", categories: [poulets, encas], order: 2)

let restaurant = Restaurant(id: UUID(), name: "La Madone", profilePic: "", profilePicHash: "UNE{2:O[-pM{0JE1RPx]-;ogs:V?NGbFs.W=", sections: [aLaUne, boissons, nourriture])
let table = Table(id: UUID(), name: "Table 12")
#endif
