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
        struct ProjectMetadata: Hashable, Equatable, Codable {
            struct Link: Hashable, Equatable, Codable {
                var name: String
                var url: String
            }
            var name: String
            var description: String
            var technologies: [String]
            var gallery: [String]
            var linkText: [String]
            var linkURL: [String]
        }

        var project: ProjectMetadata?
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://halonso.dev")!
    var name = "halonso.dev"
    var description = ""
    var language: Language { .english }
    var imagePath: Path? { nil }
}

extension SwiftPersonalPortfolio.ItemMetadata.ProjectMetadata {
    var link: [Link] {
        guard linkText.count == linkURL.count else {
            return []
        }

        return (0..<linkText.count).map { index in
            Link(name: linkText[index], url: linkURL[index])
        }
    }
}

try SwiftPersonalPortfolio().publish(withTheme: .portfolio)
