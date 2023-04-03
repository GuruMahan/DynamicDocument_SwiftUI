//
//  DocumentViewModel.swift
//  DynamicDocumentUI
//
//  Created by Guru Mahan on 09/01/23.
//

import Foundation

class DocumentViewModel: ObservableObject{
    @Published var documentModel = [DocumentModel]()
    @Published var selectedIndex = 0
    
    init() {
        let item1 = DocumentModel(title: "ID Proof", subtile: "Resident / National id",maxMb: "(max 8mb)",placeHolder: "Upload ID Proof")
        documentModel.append(item1)
        let item2 = DocumentModel(title: "Address Details", subtile: "Postal Address",maxMb: "(max 8mb)",placeHolder: "Upload Address Details")
        documentModel.append(item2)
        let item3 = DocumentModel(title: "Address Details", subtile: "Postal Address",maxMb: "(max 8mb)",placeHolder: "Upload Address Details")
        documentModel.append(item3)
    }
}
