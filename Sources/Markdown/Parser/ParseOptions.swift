/*
 This source file is part of the Swift.org open source project

 Copyright (c) 2021 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception

 See https://swift.org/LICENSE.txt for license information
 See https://swift.org/CONTRIBUTORS.txt for Swift project authors
*/

/// Options for parsing Markdown.
public struct ParseOptions: OptionSet {
    public var rawValue: UInt

    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }

    /// Enable block directive syntax.
    public static let parseBlockDirectives = ParseOptions(rawValue: 1 << 0)

    /// Enable interpretation of symbol links from inline code spans surrounded by two backticks.
    public static let parseSymbolLinks = ParseOptions(rawValue: 1 << 1)
    
    /// Disable converting straight quotes to curly, --- to em dashes, -- to en dashes during parsing
    public static let disableSmartOpts = ParseOptions(rawValue: 1 << 2)
    
    /// Include reference-link definitions such as `[Apple]: https://apple.com` in the document tree.
    public static let parseReferenceLinkDefinitions = ParseOptions(rawValue: 1 << 3)
}

