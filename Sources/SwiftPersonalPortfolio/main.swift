import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct SwiftPersonalPortfolio: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case about
        case projects
        //case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://halonso.dev")!
    var name = "halonso.dev"
    var description = ""
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try SwiftPersonalPortfolio().publish(withTheme: .foundation)
