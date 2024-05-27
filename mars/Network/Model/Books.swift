

import Foundation

struct Books: Codable {
    let kind: String
    let totalItems: Int
    let items: [Items]
    
    
    struct Items: Codable {
        let id: String
        let etag: String
        let selfLink: String
        let volumeInfo: VolumeInfo
        let saleInfo: SaleInfo
        let accessInfo: AccessInfo
    }
    
    // MARK: - AccessInfo
    struct AccessInfo: Codable {
        let country, viewability: String
    }
    
    // MARK: - SaleInfo
    struct SaleInfo: Codable {
        let country, saleability: String
        let isEbook: Bool
    }
    
    // MARK: - VolumeInfo
    struct VolumeInfo: Codable {
        let title: String
        let authors: [String]?
        let publisher, publishedDate: String?
        let description: String?
        let pageCount, printedPageCount: Int?
        let printType: String
        let categories: [String]?
        let maturityRating: String
        let allowAnonLogging: Bool
        let contentVersion: String
        let imageLinks: ImageLinks?
        let language: String
        let previewLink: String
        let infoLink, canonicalVolumeLink: String
    }
    
    // MARK: - ImageLinks
    struct ImageLinks: Codable {
        let smallThumbnail, thumbnail, small, medium: String?
        let large, extraLarge: String?
    }
}


//
//struct Books: Codable {
//    let kind: String
//    let totalItems: Int
//    let items: [Items]
//}
//
//struct Items: Codable {
//    let kind: String
//    let id: String
//    let etag: String
//    let selfLink: String
//    let volumeInfo: VolumeInfo
//    let saleInfo: SaleInfo
//    let accessInfo: AccessInfo
//}
//
//// MARK: - AccessInfo
//struct AccessInfo: Codable {
//    let country, viewability: String
//    let embeddable, publicDomain: Bool
//    let textToSpeechPermission: String
//    let epub: Epub
//    let pdf: PDF
//    let webReaderLink: String
//    let accessViewStatus: String
//    let quoteSharingAllowed: Bool
//}
//
//// MARK: - Epub
//struct Epub: Codable {
//    let isAvailable: Bool
//}
//
//// MARK: - PDF
//struct PDF: Codable {
//    let isAvailable: Bool
//    let acsTokenLink: String?
//}
//
//// MARK: - SaleInfo
//struct SaleInfo: Codable {
//    let country, saleability: String
//    let isEbook: Bool
//}
//
//// MARK: - VolumeInfo
//struct VolumeInfo: Codable {
//    let title: String
//    let authors: [String]
//    let publisher, publishedDate:String?
//    let description: String?
//    let readingModes: ReadingModes
//    let pageCount, printedPageCount: Int?
//    let printType: String
//    let categories: [String]
//    let maturityRating: String
//    let allowAnonLogging: Bool
//    let contentVersion: String
//    let panelizationSummary: PanelizationSummary
//    let imageLinks: ImageLinks
//    let language: String
//    let previewLink: String
//    let infoLink, canonicalVolumeLink: String
//}
//
//// MARK: - ImageLinks
//struct ImageLinks: Codable {
//    let smallThumbnail, thumbnail, small, medium: String?
//    let large, extraLarge: String?
//}
//
//// MARK: - PanelizationSummary
//struct PanelizationSummary: Codable {
//    let containsEpubBubbles, containsImageBubbles: Bool
//}
//
//// MARK: - ReadingModes
//struct ReadingModes: Codable {
//    let text, image: Bool
//}
