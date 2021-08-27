@testable import kindaVim
import XCTest


class FailingASVM_o_Tests: FailingASVM_BaseTests {
    
    override func setUp() {
        super.setUp()
        
        KindaVimEngine.shared.handle(keyCombination: KeyCombination(key: .o))
    }
    
}


extension FailingASVM_o_Tests {
    
    func test_that_it_does_not_calls_any_KS_function_because_this_move_is_not_implemented() {
        XCTAssertEqual(ksVisualModeMock.functionCalled, "")
    }
    
}
