@testable import kindaVim
import XCTest


class UsingASNM_yiLeftBrace_Tests: UsingASNM_BaseTests {
    
    override func setUp() {
        super.setUp()
        
        KindaVimEngine.shared.lastYankStyle = .linewise
        
        KindaVimEngine.shared.handle(keyCombination: KeyCombination(key: .y))
        KindaVimEngine.shared.handle(keyCombination: KeyCombination(key: .i))
        KindaVimEngine.shared.handle(keyCombination: KeyCombination(vimKey: .leftBrace))
    }
    
}


// see yi( for blah blah
extension UsingASNM_yiLeftBrace_Tests {
    
    func test_that_it_calls_the_correct_function_on_accessibility_strategy() {
        XCTAssertEqual(asNormalModeMock.functionCalled, "yiLeftBrace(on:)")
    }
    
    func test_that_it_keeps_Vim_in_normal_mode() {
        XCTAssertEqual(KindaVimEngine.shared.currentMode, .normal)
    }
    
}
