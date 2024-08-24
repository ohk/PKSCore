import XCTest
@testable import PKSFoundation

final class PKSBaseDateStyleTests: XCTestCase {
    // MARK: Variables
    var date: Date?

    // MARK: Set Up
    override func setUp() {
        super.setUp()
        
        // Set the time zone to GMT+0
        TimeZone.ReferenceType.default = .gmt
        
        // Set up the date variable - 08/23/2024 2:15:17 - GMT+0
        date = Date(timeIntervalSince1970: 1724454917)
    }

    // MARK: Tear Down
    override func tearDown() {
        date = nil
        super.tearDown()
    }

    // MARK: Tests
    func testFormattedDate_Date() {
        // Given
        let dateStyle = PKSBaseDateStyle.date

        // When
        let formattedDate = dateStyle.formatted(date: date!)

        // Then
        XCTAssertEqual(formattedDate, "8/23/24")
    }

    func testFormattedDate_Time() {
        // Given
        let dateStyle = PKSBaseDateStyle.time

        // When
        let formattedTime = dateStyle.formatted(date: date!)

        // Then
        XCTAssertEqual(formattedTime, "11:15 PM")

    }

    func testFormattedDate_Relative_Today() {
        // Given
        let dateStyle = PKSBaseDateStyle.relative
        
        // When
        let today = Date()
        let formattedRelative = dateStyle.formatted(date: today)
        
        // Then
        XCTAssertEqual(formattedRelative, "Today")
    }

    func testFormattedDate_Relative_Yesterday() {
        // Given
        let dateStyle = PKSBaseDateStyle.relative
        
        // When
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let formattedRelative = dateStyle.formatted(date: yesterday)
        
        // Then
        XCTAssertEqual(formattedRelative, "Yesterday")
    }

    func testFormattedDate_Relative_Tomorrow() {
        // Given
        let dateStyle = PKSBaseDateStyle.relative
        
        // When
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let formattedRelative = dateStyle.formatted(date: tomorrow)
        
        // Then
        XCTAssertEqual(formattedRelative, "Tomorrow")
    }

    func testFormattedDate_Relative_1_Week_Later() {
        // Given
        let dateStyle = PKSBaseDateStyle.relative
        
        // When
        let nextWeek = Calendar.current.date(byAdding: .day, value: 7, to: Date())!
        let formattedRelative = dateStyle.formatted(date: nextWeek)
        
        // Then
        XCTAssertEqual(formattedRelative, "Aug 30, 2024")
    }

    func testFormattedDate_Relative_1_Week_Ago() {
        // Given
        let dateStyle = PKSBaseDateStyle.relative
        
        // When
        let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let formattedRelative = dateStyle.formatted(date: lastWeek)
        
        // Then
        XCTAssertEqual(formattedRelative, "Aug 16, 2024")
    }

    
    func testFormattedDate_Full() {
        // Given
        let dateStyle = PKSBaseDateStyle.full

        // When
        let formattedFull = dateStyle.formatted(date: date!)

        // Then
        XCTAssertEqual(formattedFull, "8/23/24, 11:15 PM")
    }

    func testFormattedDate_Custom() {
        // Given
        let dateStyle = PKSBaseDateStyle.custom("yyyy-MM-dd")

        // When
        let formattedCustom = dateStyle.formatted(date: date!)

        // Then
        XCTAssertEqual(formattedCustom, "2024-08-23")
    }

//    func testFormattedDate_ChatRelative_Today_12HR() {
//        // Given
//        let dateStyle = PKSBaseDateStyle.chatRelative
//        
//        // When
//        let today = Date()
//        let formattedChatRelative = dateStyle.formatted(date: today)
//        
//        // Then
//        let locale = Locale.current
//        Calendar.current.locale = Locale(identifier: "en-US")
//        let timeFormat = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: "en-US")!
//        let expectedTime = today.formatted("h:mm a")
//        XCTAssertEqual(formattedChatRelative, expectedTime)
//        Locale.current = locale
//    }
//
//    func testFormattedDate_ChatRelative_Today_24HR() {
//        // Given
//        let dateStyle = PKSBaseDateStyle.chatRelative
//        
//        // When
//        let today = Date()
//        let formattedChatRelative = dateStyle.formatted(date: today)
//        
//        // Then
//        let locale = Locale.current
//        Locale.current = Locale(identifier: "en_GB")
//        let timeFormat = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: "en_GB")!
//        let expectedTime = today.formatted("HH:mm")
//        XCTAssertEqual(formattedChatRelative, expectedTime)
//        Locale.current = locale
//    }

    func testFormattedDate_ChatRelative_Yesterday() {
        // Given
        let dateStyle = PKSBaseDateStyle.chatRelative
        
        // When
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let formattedChatRelative = dateStyle.formatted(date: yesterday)
        
        // Then
        XCTAssertEqual(formattedChatRelative, "Yesterday")
    }

    func testFormattedDate_ChatRelative_Tomorrow() {
        // Given
        let dateStyle = PKSBaseDateStyle.chatRelative
        
        // When
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let formattedChatRelative = dateStyle.formatted(date: tomorrow)
        
        // Then
        XCTAssertEqual(formattedChatRelative, "Tomorrow")
    }


}
