/*
 This source file is part of the Swift.org open source project

 Copyright (c) 2021 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception

 See https://swift.org/LICENSE.txt for license information
 See https://swift.org/CONTRIBUTORS.txt for Swift project authors
*/

/// An unordered list.
public struct UnorderedList: ListItemContainer {
    public var _data: _MarkupData
    init(_ raw: RawMarkup) throws {
        guard case .unorderedList = raw.data else {
            throw RawMarkup.Error.concreteConversionError(from: raw, to: UnorderedList.self)
        }
        let absoluteRaw = AbsoluteRawMarkup(markup: raw, metadata: MarkupMetadata(id: .newRoot(), indexInParent: 0))
        self.init(_MarkupData(absoluteRaw))
    }

    init(_ data: _MarkupData) {
        self._data = data
    }
}

// MARK: - Public API

public extension UnorderedList {
    // MARK: ListItemContainer

    init<Items: Sequence>(_ items: Items) where Items.Element == ListItem {
        try! self.init(.unorderedList(parsedRange: nil, items.map { $0.raw.markup }, tight: false)) // TODO: Is `tight: false` appropriate here?
    }

    /// Whether the list is "tight" (item content should not be wrapped in paragraphs).
    var tight: Bool {
        get {
            guard case let .unorderedList(tight) = _data.raw.markup.data else {
                fatalError("\(self) markup wrapped unexpected \(_data.raw)")
            }
            return tight
        }
        set {
            guard tight != newValue else {
                return
            }
            _data = _data.replacingSelf(.unorderedList(parsedRange: nil, _data.raw.markup.copyChildren(), tight: newValue))
        }
    }

    // MARK: Visitation

    func accept<V: MarkupVisitor>(_ visitor: inout V) -> V.Result {
        return visitor.visitUnorderedList(self)
    }
}
