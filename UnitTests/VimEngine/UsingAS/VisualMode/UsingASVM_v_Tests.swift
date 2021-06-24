@testable import kindaVim
import XCTest


class UsingASVM_v_Tests: UsingASVM_BaseTests {
        
    func test_that_it_calls_the_correct_function_on_accessibility_strategy_visual_mode() {
        VimEngine.shared.handle(keyCombination: KeyCombination(key: .v))
        
        XCTAssertEqual(asVisualModeMock.functionCalled, "v(on:)")
    }
        
    func test_that_if_Vim_was_in_visual_mode_characterwise_it_switches_into_normal_mode() {
        VimEngine.shared.handle(keyCombination: KeyCombination(key: .v))
        
        XCTAssertEqual(VimEngine.shared.currentMode, .normal)
    }
    
    func test_that_if_Vim_was_in_visual_mode_linewise_it_switches_into_visual_mode_characterwise() {
        VimEngine.shared.visualStyle = .linewise
        VimEngine.shared.handle(keyCombination: KeyCombination(key: .v))
        
        XCTAssertEqual(VimEngine.shared.currentMode, .visual)
        XCTAssertEqual(VimEngine.shared.visualStyle, .characterwise)
    }
    
}