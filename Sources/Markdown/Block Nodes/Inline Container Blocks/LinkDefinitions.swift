// A block that contains only reference-link definitions, such as `[Apple]: https://apple.com`.
// Modeled after `Paragraph`.
public struct LinkDefinitions: BlockMarkup {
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

    /// The raw text of the element.
    var string: String {
        get {
            guard case let .linkDefinitions(string) = _data.raw.markup.data else {
                fatalError("\(self) markup wrapped unexpected \(_data.raw)")
            }
            return string
        }
    }

    // MARK: Visitation

    func accept<V: MarkupVisitor>(_ visitor: inout V) -> V.Result {
        return visitor.visitLinkDefinitions(self)
    }
}
