//
//  ContactMachine.swift
//  balangir
//
//  Created by Alexander Rohrig on 12/19/21.
//

import Foundation
import Contacts
import SwiftUI

class GetContacts {
    func getContacts() -> [ContactModel] {
        var contacts = [ContactModel]()
        let keys = [CNContactGivenNameKey,
                    CNContactFamilyNameKey,
                    CNContactMiddleNameKey,
                    CNContactNameSuffixKey,
                    CNContactNamePrefixKey,
                    CNContactThumbnailImageDataKey,
                    CNContactImageDataAvailableKey,
                    CNContactBirthdayKey,
                    CNContactNicknameKey,
                    CNContactPhoneNumbersKey,
                    CNContactEmailAddressesKey,
                    CNContactPostalAddressesKey,
                    CNContactOrganizationNameKey,
//                    CNContactNoteKey,
                    CNContactTypeKey,
                    CNContactIdentifierKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
//        let request = CNContactFetchRequest(keysToFetch: [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)])
        do {
//            DispatchQueue.main.sync {
//                <#code#>
//            }
            try CNContactStore().enumerateContacts(with: request, usingBlock: {(contact, stopPointer) in
                contacts.append(ContactModel(info: contact))
            })
        }
        catch let error {
            print("unable to get contacts: \(error)")
        }
        
        contacts = contacts.sorted {
            return $0.info.familyName.localizedUppercase < $1.info.familyName.localizedUppercase
        }
        
//        print(contacts)
        
        return contacts
        
    }
    
    func getLongLocalizedNameFrom(contact: CNContact, withStyle: PersonNameComponentsFormatter.Style) -> String {
        let nameFormatter = PersonNameComponentsFormatter()
        nameFormatter.style = withStyle
        var nameComponents = PersonNameComponents()
        if !contact.familyName.isEmpty {
            nameComponents.familyName = contact.familyName
        }
        if !contact.givenName.isEmpty {
            nameComponents.givenName = contact.givenName
        }
        if !contact.middleName.isEmpty {
            nameComponents.middleName = contact.middleName
        }
        if !contact.nameSuffix.isEmpty {
            nameComponents.nameSuffix = contact.nameSuffix
        }
        if !contact.namePrefix.isEmpty {
            nameComponents.namePrefix = contact.namePrefix
        }
        return nameFormatter.string(from: nameComponents)
    }
    
    func formatPhoneNumber(fromString: String) -> String {
        let countryCode2D = fromString.prefix(3)
        let countryCode1D = fromString.prefix(2)
        
//        Check for countries
        if countryCode1D == "+1" {
            // Nanp
            // +1 XXX XXX XXXX
            print("Nanp number")
        }
        else if countryCode1D == "+7" {
            // Russia
            // +7 XXX XXX XXXX
            print("Russian number")
        }
        else if countryCode2D == "+39" {
            // Italy
            // +39 XXX XXX XXXX
            print("Italian number")
        }
        else if countryCode2D == "+49" {
            // Germany
            // +49 XX XXXX XXXX
            print("German number")
        }
        else {
            // local number
            print("\(Locale.autoupdatingCurrent) number \(fromString)")
            return fromString
        }
        return fromString
        
        /*
         from +12147716676
         to
         National         (214) 771 6676
         International +1  214  771 6676
         
         China:
         +86 135 5555 5555
         
         Italy:
         +39 355 555 5555
         
         Germany:
         +49 17 3262 7110
         
         Russia:
         +7 955 555 5555
         
         Replace + with From Country Code (011 for USA)
         Do not use ( ) in international numbers
         
         */
    }
    
}

struct ContactModel: Identifiable {
    var id = UUID()
    var info: CNContact!
}

extension Image {
    init(universalFromData: Data) {
        self.init(systemName: "questionmark.circle.fill")
//        print("Creating image using universalFromData extension...")
        #if canImport(UIKit)
        if let u = UIImage(data: universalFromData) {
            self.init(uiImage: u)
        }
        else {
            print("Unable to produce UIImage")
        }
        #elseif canImport(AppKit)
        if let n = NSImage(data: universalFromData) {
            self.init(nsImage: n)
        }
        else {
            print("Unable to produce NSImage")
        }
        #endif
    }
}

struct ButtonStyleUno: ButtonStyle {
    let backgroundColor = Color(.displayP3, red: 0.93, green: 0.93, blue: 0.93, opacity: 1.0)
    var image: Image
    var labelSecondo: String?
    func makeBody(configuration: Configuration) -> some View {
        VStack{
            if let s = labelSecondo {
                Text(s)
                    .font(.system(size: 10))
            }
            image
                .padding(1)
            configuration.label
                .font(.system(size: 10))
        }
            .frame(idealHeight: 40, maxHeight: 40)
            .padding()
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
//            .background(
//                ZStack{
//                    RoundedRectangle(cornerRadius: 10)
//                        .fill(backgroundColor)
//                })
    }
}
