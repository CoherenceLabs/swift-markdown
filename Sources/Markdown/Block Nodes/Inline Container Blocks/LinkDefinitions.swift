// A block that contains only reference-link definitions, such as `[Apple]: https://apple.com`.
public struct LinkDefinitions: BlockMarkup, BasicInlineContainer {
    public var _data: _MarkupData
    init(_ data: _MarkupData) {
        self._data = data
    }

    init(_ raw: RawMarkup) throws {
        guard case .linkDefinitions = raw.data else {
            throw RawMarkup.Error.concreteConversionError(from: raw, to: Paragraph.self)
        }
        let absoluteRaw = AbsoluteRawMarkup(markup: raw, metadata: MarkupMetadata(id: .newRoot(), indexInParent: 0))
        self.init(_MarkupData(absoluteRaw))
    }
}

// MARK: - Public API

public extension LinkDefinitions {
    // MARK: InlineContainer

    init<Children: Sequence>(_ newChildren: Children) where Children.Element == InlineMarkup {
        try! self.init(.paragraph(parsedRange: nil, newChildren.map { $0.raw.markup }))
    }

    /// The raw text of the element.
    var string: String {
        get {
            guard case let .linkDefinitions(string) = _data.raw.markup.data else {
                fatalError("\(self) markup wrapped unexpected \(_data.raw)")
            }
            return string
        }
        set {
            _data = _data.replacingSelf(.linkDefinitions(parsedRange: nil, string: newValue))
        }
    }

    // MARK: PlainTextConvertibleMarkup

    var plainText: String {
        return string
    }

    // MARK: Visitation

    func accept<V: MarkupVisitor>(_ visitor: inout V) -> V.Result {
        return visitor.visitLinkDefinitions(self)
    }
}
