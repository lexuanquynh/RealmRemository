//
//  PetTests.swift
//  RealmManagerTests
//
//  Created by Admin on 2022/07/14.
//

import XCTest
@testable import RealmManager

final class PetTests: XCTestCase {
    let repository = PetRepository()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSaveDog() throws {
        let expectation = self.expectation(description: "Realm save API")
        let dog = Dog(value: ["name": "Max", "age": 5])

        repository.save(entity: dog, update: false) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
                expectation.fulfill()
            case .failure:
                XCTAssertTrue(false)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testSavePersonsWithPrimaryKey() throws {
        let expectation = self.expectation(description: "Realm save API")

        let aDog = Dog(value: ["name": "Lulu", "age": 3])
        let anotherDog = Dog(value: ["name": "Nana", "age": 2])

        // Instead of using pre-existing dogs...
        let aPerson = Person(value: [123, "Jane", [aDog, anotherDog]])
        // ...we can create them inline
        let anotherPerson = Person(value: [456, "Jane", [["Buster", 5], ["Buddy", 6]]])

        repository.save(entities: [aPerson, anotherPerson], update: true) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
                expectation.fulfill()
            case .failure:
                XCTAssertTrue(false)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testSaveDogToyWithJSON() throws {
        let expectation = self.expectation(description: "Realm save API")
        // Specify a dog toy in JSON
        let data = "{\"name\": \"Tennis ball\"}".data(using: .utf8)!
        repository.save(saveClass: DogToy.self, jsonData: data, update: false) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
                expectation.fulfill()
            case .failure:
                XCTAssertTrue(false)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
