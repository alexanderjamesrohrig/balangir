//
//  ContactRowView.swift
//  balangir
//
//  Created by Alexander Rohrig on 12/19/21.
//

import SwiftUI
import Contacts

struct ContactRowView: View {
    var contact: CNContact
    let imageSize: CGFloat = 50
    let cformat = CNContactFormatter()
//    cformat.style = .fullName
    var body: some View {
        HStack {
            switch contact.contactType {
            case .organization:
                if contact.imageDataAvailable {
                    if let d = contact.thumbnailImageData {
                        Image(universalFromData: d)
                            .resizable()
                            .frame(minWidth: imageSize, maxWidth: imageSize, minHeight: imageSize, maxHeight: imageSize).scaledToFit()
                    }
                }
                else {
                    Image(systemName: "building.2.crop.circle")
                        .resizable()
                        .frame(minWidth: imageSize, maxWidth: imageSize, minHeight: imageSize, maxHeight: imageSize).scaledToFit()
                }
                Text(contact.organizationName)
            case .person:
                if contact.imageDataAvailable {
                    if let d = contact.thumbnailImageData {
                        Image(universalFromData: d)
                            .resizable()
                            .frame(minWidth: imageSize, maxWidth: imageSize, minHeight: imageSize, maxHeight: imageSize).scaledToFit()
                    }
                }
                else {
                    Text(GetContacts().getLongLocalizedNameFrom(contact: contact, withStyle: .abbreviated))
                        .frame(minWidth: imageSize, maxWidth: imageSize, minHeight: imageSize, maxHeight: imageSize).scaledToFit()
                        .bold()
                }
                Text(GetContacts().getLongLocalizedNameFrom(contact: contact, withStyle: .long))
            default:
                Text("Error - ContactRowView")
            }
            
            
        }
    }
}
