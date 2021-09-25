@testable import kindaVim
import KeyCombination
import XCTest


class SucceedingASNM_rightBracketRightParenthesis_Tests: SucceedingASNM_BaseTests {
    
    override func setUp() {
        super.setUp()
        
        KindaVimEngine.shared.handle(keyCombination: KeyCombination(key: .rightBracket))
        KindaVimEngine.shared.handle(keyCombination: KeyCombination(vimKey: .rightParenthesis))
    }
    
}


extension SucceedingASNM_rightBracketRightParenthesis_Tests {
    
    func test_that_it_calls_the_correct_function_on_accessibility_strategy() {
        XCTAssertEqual(asNormalModeMock.functionCalled, "rightBracketRightParenthesis(on:)")
    }
    
    func test_that_it_keeps_Vim_in_normal_mode() {
        XCTAssertEqual(KindaVimEngine.shared.currentMode, .normal)
    }
    
}