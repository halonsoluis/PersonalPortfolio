//
//  Theme+Portfolio.swift
//
//  Created by Hugo Alonso on 11/11/2020.
//

import Plot
import Publish

public extension Theme {
    /// The default "Foundation" theme that Publish ships with, a very
    /// basic theme mostly implemented for demonstration purposes.
    static var portfolio: Self {
        Theme(
            htmlFactory: PortfolioHTMLFactory(),
            resourcePaths: ["Resources/PortfolioTheme/styles.css"]
        )
    }
}

private struct PortfolioHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1(.text(index.title))
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body(
                .header(for: context, selectedSection: section.id),
                .wrapper(
                    .h1(.text(section.title)),
                    .if(SwiftPersonalPortfolio.SectionID.projects.rawValue == section.id.rawValue,
                        .projectList(
                            for: section.items,
                            on: context.site
                        ),
                        else:
                            .itemList(for: section.items, on: context.site))

                ),
                .footer(for: context.site)
            )
        )
    }

    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("item-page"),
                .header(for: context, selectedSection: item.sectionID),
                .wrapper(
                    .article(
                        .div(
                            .class("content"),
                            .contentBody(item.body)
                        ),
                        .span("Tagged with: "),
                        .tagList(for: item, on: context.site)
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(.contentBody(page.body)),
                .footer(for: context.site)
            )
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1("Browse all tags"),
                    .ul(
                        .class("all-tags"),
                        .forEach(page.tags.sorted()) { tag in
                            .li(
                                .class("tag"),
                                .a(
                                    .href(context.site.path(for: tag)),
                                    .text(tag.string)
                                )
                            )
                        }
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1(
                        "Tagged with ",
                        .span(.class("tag"), .text(page.tag.string))
                    ),
                    .a(
                        .class("browse-all"),
                        .text("Browse all tags"),
                        .href(context.site.tagListPath)
                    ),
                    .itemList(
                        for: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }

    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases

        return .header(
            .wrapper(
                .a(.class("site-name"), .href("/"), .text(context.site.name)),
                .if(sectionIDs.count > 1,
                    .nav(
                        .ul(.forEach(sectionIDs) { section in
                            .li(.a(
                                .class(section == selectedSection ? "selected" : ""),
                                .href(context.sections[section].path),
                                .text(context.sections[section].title)
                            ))
                        })
                    )
                )
            )
        )
    }

    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h1(.text(item.title)),
                    .contentBody(item.body)
                ))
            }
        )
    }

    static func projectList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        
        return .ul(
            .class("item-list"),
            .forEach(items) { item in

                guard let metadata = item.metadata as? SwiftPersonalPortfolio.ItemMetadata else {
                    return .empty
                }

                guard let project = metadata.project else {
                    return .empty
                }

                return .li(
                    .project(for: project),
                    .contentBody(item.body)
                )
            }
        )
    }

    static func project(for project: SwiftPersonalPortfolio.ItemMetadata.ProjectMetadata) -> Node {

        return .article(
            .h1(.text(project.name)),
            .links(for: project.link),
            .technologies(for: project.technologies),
            .p(.text(project.description)),
            .gallery(for: project.gallery)
        )
    }

    static func technologies(for technologies: [String]) -> Node {
        guard !technologies.isEmpty else {
            return .empty
        }

        return .ul(.class("tag-list"), .forEach(technologies) { tag in
            .li(.a(
                .text(tag)
            ))
        })
    }

    static func links(for links: [SwiftPersonalPortfolio.ItemMetadata.ProjectMetadata.Link]) -> Node {
        guard !links.isEmpty else {
            return .empty
        }

        return .ul(.class("link-list"), .forEach(links) { link in
            .li(.a(
                .target(.blank),
                .href(link.url),
                .text(link.name)
            ))
        })
    }

    static func gallery(for gallery: [String]) -> Node {
        guard !gallery.isEmpty else {
            return .empty
        }

        return .div(.class("gallery"), .forEach(gallery) { image in
            .a(
                .target(.blank),
                .href(image),
                .img(.class("gallery-item"), .src(image))
            )
        })
    }

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }

    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .p(
                .text("Generated using "),
                .a(
                    .text("Publish"),
                    .href("https://github.com/johnsundell/publish")
                )
            ),
            .p(.a(
                .text("RSS feed"),
                .href("/feed.rss")
            ))
        )
    }
}

