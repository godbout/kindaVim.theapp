//
//  UndosTests.swift
//  kindaVimTests
//
//  Created by Guillaume Leclerc on 28/04/2021.
//

@testable import kindaVim
import XCTest

class UndosTests: XCTestCase {
    
    func test_that_u_gets_transformed_to_command_z() {
        let u = KeyCombination(key: .u)

        let transformedKeys = VimEngineController.shared.transform(from: u)

        XCTAssertEqual(transformedKeys.count, 2)
        XCTAssertEqual(transformedKeys[0].key, .z)
        XCTAssertEqual(transformedKeys[0].command, true)
        XCTAssertEqual(transformedKeys[0].action, .press)
        XCTAssertEqual(transformedKeys[1].key, .z)
        XCTAssertEqual(transformedKeys[1].command, true)
        XCTAssertEqual(transformedKeys[1].action, .release)
    }

}
