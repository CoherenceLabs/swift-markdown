// A block that contains only reference-link definitions, such as `[Apple]: https://apple.com`.
// Modeled after `Paragraph`.
public struct LinkDefinitions: BlockMarkup, BasicInlineContainer {
    public var _data: _MarkupData
    init(_ data: _MarkupData) {
        self._data = data
    }

    init(_ raw: RawMarkup) throws {
        guard case .linkDefinitions = raw.data else {
            throw RawMarkup.Error.concreteConversionError(from: raw, to: LinkDefinitions.self)
        }
        let absoluteRaw = AbsoluteRawMarkup(markup: raw, metadata: MarkupMetadata(id: .newRoot(), indexInParent: 0))
        self.init(_MarkupData(absoluteRaw))
    }
}

// MARK: - Public API

public extension LinkDefinitions {
    // MARK: InlineContainer

    init<Children: Sequence>(_ newChildren: Children) where Children.Element == InlineMarkup {
        try! self.init(.linkDefinitions(parsedRange: nil, newChildren.map { $0.raw.markup }))
    }

    // MARK: Visitation

    func accept<V: MarkupVisitor>(_ visitor: inout V) -> V.Result {
        return visitor.visitLinkDefinitions(self)
    }
}
