import XCTest
@testable import PKSFoundation

final class DateExtTests: XCTestCase {
    // MARK: Variables
    var date: Date!

    // MARK: Set Up
    override func setUp() {
        super.setUp()
        date = Date()
    }

    // MARK: Tear Down
    override func tearDown() {
        date = nil
        super.tearDown()
    }

    // MARK: Tests
    func testTomorrow() {
        let tomorrow = date.tomorrow
        let expectedTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        XCTAssertEqual(tomorrow, expectedTomorrow)
    }

    func testYesterday() {
        let yesterday = date.yesterday
        let expectedYesterday = Calendar.current.date(byAdding: .day, value: -1, to: date)!
        XCTAssertEqual(yesterday, expectedYesterday)
    }
}
