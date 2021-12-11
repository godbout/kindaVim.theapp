@testable import kindaVim
import KeyCombination
import XCTest


class EnforcingKS_yiw_Tests: EnforcingKSNM_BaseTests {

    override func setUp() {
        super.setUp()
        
        kindaVimEngine.handle(keyCombination: KeyCombination(vimKey: .eight), appMode: .keyMapping)
        kindaVimEngine.handle(keyCombination: KeyCombination(key: .y), appMode: .keyMapping)
        kindaVimEngine.handle(keyCombination: KeyCombination(key: .i), appMode: .keyMapping)
        kindaVimEngine.handle(keyCombination: KeyCombination(key: .w), appMode: .keyMapping)
    }

}


extension EnforcingKS_yiw_Tests {

    func test_that_yiw_calls_the_ciw_function_on_keyboard_strategy() {
        XCTAssertEqual(ksNormalModeMock.functionCalled, "yiw()")
    }

    func test_that_yiw_keeps_Vim_in_normal_mode() {
        XCTAssertEqual(kindaVimEngine.currentMode, .normal)
    }
    
    func test_that_it_resets_the_count() {
        XCTAssertNil(kindaVimEngine.count)
    }

}