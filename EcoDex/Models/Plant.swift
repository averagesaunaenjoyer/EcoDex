//
//  Plant.swift
//  EcoDex
//
//  Created by Serafin dela Paz on 4/18/23.
//

import Foundation

struct Plant: Decodable, Identifiable {
    let id: Int
    let name: String
    let scientific: String
    let imageURL: String
    let type: String
}

let mockPlant: [Plant] = [
    .init(id: 0, name: "Verbena", scientific: "Verbena californica", imageURL: "Verbena", type: "Flower"),
    .init(id: 1, name: "Verbena", scientific: "Verbena californica", imageURL: "Verbena", type: "Flower"),
    .init(id: 2, name: "Verbena", scientific: "Verbena californica", imageURL: "Verbena", type: "Flower"),
    .init(id: 3, name: "Verbena", scientific: "Verbena californica", imageURL: "Verbena", type: "Flower"),
    .init(id: 4, name: "Verbena", scientific: "Verbena californica", imageURL: "Verbena", type: "Flower"),
    .init(id: 5, name: "Verbena", scientific: "Verbena californica", imageURL: "Verbena", type: "Flower")
]

