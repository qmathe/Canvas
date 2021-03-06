import XCTest
import CanvasNative

final class TitleTest: XCTestCase {
	func testTitle() {
		let node = Title(string: "⧙doc-heading⧘Hello", range: NSRange(location: 0, length: 18))!
		XCTAssertEqual(NSRange(location: 0, length: 13), node.nativePrefixRange)
		XCTAssertEqual(NSRange(location: 13, length: 5), node.visibleRange)
	}

	func testInline() {
		let node = Parser.parse("⧙doc-heading⧘Hello **world**").first! as! Title
		XCTAssertEqual(NSRange(location: 13, length: 15), node.textRange)
		XCTAssert(node.subnodes[0] is Text)
		XCTAssert(node.subnodes[1] is DoubleEmphasis)
	}
}
