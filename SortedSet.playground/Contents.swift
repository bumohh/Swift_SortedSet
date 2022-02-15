import UIKit
import XCTest

struct SortedSet<T : Comparable> {
    var set = [T]()
    
    mutating func addOne(_ element : T) {
        if !has(element) {
            guard let index = getIndexToInsert(element) else { return }
            set.insert(element, at : index)
        }
    }
    
    mutating func addMany(_ arr : [T]) {
        for element in arr {
            addOne(element)
        }
    }
    mutating func delete(_ element : T) {
        set.removeAll {
            $0 == element
        }
    }
    mutating func deleteAll() {
        set.removeAll()
    }
    func max() -> T? {
        let max = set.max()
        return max
    }
    func min() -> T? {
        let min = set.min()
        return min
    }
    
    func has(_ element : T) -> Bool {
        if set.contains(element) {
            return true
        }
        return false
    }
    
    func getSet() -> [T] {
        return set
    }
    
    func getIndexToInsert(_ element : T) -> Int? {
        guard let index = set.firstIndex(where: { num in
            num > element
        }) else {
            return getSetCount()
        }
        return index
    }
    
    func getSetCount() -> Int{
        return set.count
    }
    
}

class SortedSetTest : XCTestCase {
    var sortedSet : SortedSet<Double>?
    override func setUpWithError() throws {
        sortedSet = SortedSet()
    }
    override func tearDownWithError() throws {
        sortedSet = nil
    }
    
    func testAddOne() {
        sortedSet?.addOne(0.0)
        sortedSet?.addOne(1.0)
        XCTAssertEqual(sortedSet?.getSetCount(), 2)
        sortedSet?.addOne(0.0)
        XCTAssertEqual(sortedSet?.getSetCount(), 2)
    }
    
    func testAddMany() {
        let doubles = [0.0, 1.0, 2.0, 3.0, 4.0, 4.0, 2.0, 3.0]
        sortedSet?.addMany(doubles)
        XCTAssertEqual(sortedSet?.getSetCount(), 5)
    }
    
    func testDelete() {
        let doubles = [0.0, 1.0, 2.0, 3.0, 4.0, 4.0, 2.0, 3.0]
        sortedSet?.addMany(doubles)
        sortedSet?.delete(1.0)
        XCTAssertEqual(sortedSet?.getSetCount(), 4)
    }
    
    func testDeleteAll() {
        let doubles = [0.0, 1.0, 2.0, 3.0, 4.0, 4.0, 2.0, 3.0]
        sortedSet?.addMany(doubles)
        sortedSet?.deleteAll()
        XCTAssertEqual(sortedSet?.getSetCount(), 0)
    }
    
    func testMax() {
        let doubles = [0.0, 1.0, 2.0, 3.0, 4.0, 4.0, 2.0, 3.0]
        sortedSet?.addMany(doubles)
        let result = sortedSet?.max()
        XCTAssertEqual(result, 4.0)
    }
    
    func testMin() {
        let doubles = [0.0, 1.0, 2.0, 3.0, 4.0, 4.0, 2.0, 3.0]
        sortedSet?.addMany(doubles)
        let result = sortedSet?.min()
        XCTAssertEqual(result, 0.0)
    }
    
    func testHas() {
        let testBool0 = sortedSet?.has(1.0)
        XCTAssertEqual(testBool0, false)
        let doubles = [0.0, 1.0, 2.0, 3.0, 4.0, 4.0, 2.0, 3.0]
        sortedSet?.addMany(doubles)
        let testBool1 = sortedSet?.has(4.0)
        XCTAssertEqual(testBool1, true)
        let testBool2 = sortedSet?.has(7.0)
        XCTAssertEqual(testBool2, false)
    }
    
    func testGetSetCount() {
        XCTAssertEqual(sortedSet?.getSetCount(), 0)
        sortedSet?.addOne(5.0)
        sortedSet?.addOne(3.0)
        XCTAssertEqual(sortedSet?.getSetCount(), 2)
    }
    func testGetSet() {
        XCTAssertEqual(sortedSet?.getSet(), [])
        sortedSet?.addOne(5.0)
        sortedSet?.addOne(1.0)
        XCTAssertEqual(sortedSet?.getSet(), [1.0, 5.0])
    }
    func testGetIndexToInsert() {
        let result = sortedSet?.getIndexToInsert(5.0)
        XCTAssertEqual(result, 0)
        sortedSet?.addOne(5.0)
        let result1 = sortedSet?.getIndexToInsert(2.0)
        XCTAssertEqual(result1, 0)
        let doubles = [0.0, 1.0, 2.0, 3.0, 4.0, 4.0, 2.0, 3.0]
        sortedSet?.addMany(doubles)
        let result2 = sortedSet?.getIndexToInsert(8.0)
        XCTAssertEqual(result2, sortedSet?.getSetCount())
        sortedSet?.addOne(8.0)
        let result3 = sortedSet?.getIndexToInsert(7.0)
        XCTAssertEqual(result3, 6)
    }
}

SortedSetTest.defaultTestSuite.run()
