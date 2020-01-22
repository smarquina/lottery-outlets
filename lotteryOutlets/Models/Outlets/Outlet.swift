//
//  Outlet.swift
//  lotteryOutlets
//
//  Created by Sergio Martín on 17/01/2020.
//  Copyright © 2020 Sergio Martín. All rights reserved.
//

import Foundation

struct Outlet: Decodable {

    let identifier : String
    let name: String
    let urlPhoto: String?
    let phone: String?
    let city: String?
    let address: String?
    let latitude: Double?
    let longitude: Double?
    let email: String?
    let province: String?
    let zipCode: String?
    let enabled: Bool
    let license: String?
    let licenseName: String?
    let licenseSurname: String?
    let licenseDNI: String?
    let number: String?
    let commercial: String?
    let mapImage: String?

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name = "nombre"
        case urlPhoto = "urlFoto"
        case phone = "telefono"
        case city = "poblacion"
        case address = "direccion"
        case latitude = "latitud"
        case longitude = "longitud"
        case email = "mail"
        case province = "provincia"
        case zipCode = "codigoPostal"
        case enabled
        case license = "licencia"
        case licenseName = "licenciaNombre"
        case licenseSurname = "licenciaApellidos"
        case licenseDNI = "licenciaDni"
        case number = "numero"
        case commercial
        case mapImage

    }
}
