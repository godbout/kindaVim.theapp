@testable import kindaVim
import XCTest


// p for TextViews is special bis
// the pasting style will depend on how the last yanking was made
// if it was characterwise, pasting paste in line
// if it was linewise, pasting paste on a new line below
class UIAS_p_TextViews_Tests: UIAS_BaseTests {
    
    private func sendMoveThroughVimEngineAndGetBackUpdatedFocusedElement() -> AccessibilityTextElement? {
        VimEngine.shared.handle(keyCombination: KeyCombination(key: .p))
        
        return AccessibilityTextElementAdaptor.fromAXFocusedElement()        
    }   
    
}


// characterwise
// the 3 special cases:
// - empty TextElement
// - caret at the end of TextElement but not on empty line
// - caret at the end of TextElement on own empty line
extension UIAS_p_TextViews_Tests {    
    
    func test_that_if_the_TextArea_is_empty_it_still_pastes() {
        let textInAXFocusedElement = ""
        app.textViews.firstMatch.tap()
        app.textViews.firstMatch.typeText(textInAXFocusedElement)
        
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString("test 1 of The 3 Cases for TextArea", forType: .string)
        
        VimEngine.shared.lastYankStyle = .characterwise
        let finalElement = sendMoveThroughVimEngineAndGetBackUpdatedFocusedElement()        
        
        XCTAssertEqual(finalElement?.value, "test 1 of The 3 Cases for TextArea")
        XCTAssertEqual(finalElement?.caretLocation, 33)
    }
    
    func test_that_if_the_caret_is_at_the_last_character_of_the_TextArea_it_does_nothing_and_does_not_crash() {
        let textInAXFocusedElement = "the user has clicked out of the boundaries!"
        app.textViews.firstMatch.tap()
        app.textViews.firstMatch.typeText(textInAXFocusedElement)
        
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString("test 2 of The 3 Cases for TextArea", forType: .string)
        
        VimEngine.shared.lastYankStyle = .characterwise
        let finalElement = sendMoveThroughVimEngineAndGetBackUpdatedFocusedElement()
        
        XCTAssertEqual(finalElement?.value, "the user has clicked out of the boundaries!")
        XCTAssertEqual(finalElement?.caretLocation, 42)
    }
    
    func test_that_if_the_caret_is_at_the_last_character_of_the_TextArea_and_on_an_empty_line_it_still_pastes() {
        let textInAXFocusedElement = """
caret is on its
own empty
line

"""
        app.textViews.firstMatch.tap()
        app.textViews.firstMatch.typeText(textInAXFocusedElement)
        
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString("test 3 of The 3 Cases for TextArea", forType: .string)
        
        VimEngine.shared.lastYankStyle = .characterwise
        let finalElement = sendMoveThroughVimEngineAndGetBackUpdatedFocusedElement()
        
        XCTAssertEqual(finalElement?.value, """
caret is on its
own empty
line
test 3 of The 3 Cases for TextArea
"""
        )
        XCTAssertEqual(finalElement?.caretLocation, 64)
    }
    
}


// characterwise
// other cases
extension UIAS_p_TextViews_Tests {
    
    func test_that_in_normal_setting_it_pastes_the_text_after_the_block_cursor_and_the_block_cursor_ends_up_at_the_end_of_the_pasted_text() {
        let textInAXFocusedElement = """
time to paste
in TextViews
ho ho ho
"""
        app.textViews.firstMatch.tap()
        app.textViews.firstMatch.typeText(textInAXFocusedElement)
        app.textViews.firstMatch.typeKey(.upArrow, modifierFlags: [])
        app.textViews.firstMatch.typeKey(.leftArrow, modifierFlags: [.option])
        app.textViews.firstMatch.typeKey(.leftArrow, modifierFlags: [])
        
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString("pastaing", forType: .string)
        
        VimEngine.shared.lastYankStyle = .characterwise
        let finalElement = sendMoveThroughVimEngineAndGetBackUpdatedFocusedElement()
        
        XCTAssertEqual(finalElement?.value, """
time to paste
in pastaingTextViews
ho ho ho
"""
        )
        XCTAssertEqual(finalElement?.caretLocation, 24)
    }
    
    func test_that_pasting_on_an_empty_line_does_not_paste_on_a_line_below_but_stays_on_the_same_line_and_does_not_stick_with_the_next_line() {
        let textInAXFocusedElement = """
gonna have an empty line

here's the last one
"""
        app.textViews.firstMatch.tap()
        app.textViews.firstMatch.typeText(textInAXFocusedElement)
        app.textViews.firstMatch.typeKey(.upArrow, modifierFlags: [])
        
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString("text for the new line", forType: .string)
        
        VimEngine.shared.lastYankStyle = .characterwise
        let finalElement = sendMoveThroughVimEngineAndGetBackUpdatedFocusedElement()
        
        XCTAssertEqual(finalElement?.value, """
gonna have an empty line
text for the new line
here's the last one
"""
        )
        XCTAssertEqual(finalElement?.caretLocation, 45)    
    }
    
}


// linewise
// the 3 special cases:
// - empty TextElement
// - caret at the end of TextElement but not on empty line
// - caret at the end of TextElement on own empty line
extension UIAS_p_TextViews_Tests {
    
    func test_that_if_the_TextArea_is_empty_it_still_pastes_on_a_line_below() {
        let textInAXFocusedElement = ""
        app.textViews.firstMatch.tap()
        app.textViews.firstMatch.typeText(textInAXFocusedElement)
        
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString("test 1 of The 3 Cases for TextArea linewise", forType: .string)
        
        VimEngine.shared.lastYankStyle = .linewise
        let finalElement = sendMoveThroughVimEngineAndGetBackUpdatedFocusedElement()        
        
        XCTAssertEqual(finalElement?.value, """

test 1 of The 3 Cases for TextArea linewise
"""
        )
        XCTAssertEqual(finalElement?.caretLocation, 43)
    }
    
    func test_that_if_the_caret_is_at_the_last_character_of_the_TextArea_it_does_nothing_and_does_not_crash_even_for_linewise() {
        let textInAXFocusedElement = """
end of boundaries
cannot
"""
        app.textViews.firstMatch.tap()
        app.textViews.firstMatch.typeText(textInAXFocusedElement)
        
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString("test 2 of The 3 Cases for TextArea linewise", forType: .string)
        
        VimEngine.shared.lastYankStyle = .linewise
        let finalElement = sendMoveThroughVimEngineAndGetBackUpdatedFocusedElement()
        
        XCTAssertEqual(finalElement?.value, """
end of boundaries
cannot
"""
        )
        XCTAssertEqual(finalElement?.caretLocation, 23)
    }
    
    func test_that_if_the_caret_is_at_the_last_character_of_the_TextArea_and_on_an_empty_line_it_still_pastes_but_without_an_ending_linefeed() {
        let textInAXFocusedElement = """
this should paste
after a new line and
not add a linefeed

"""
        app.textViews.firstMatch.tap()
        app.textViews.firstMatch.typeText(textInAXFocusedElement)
        
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString("test 3 of The 3 Cases for TextArea linewise\n", forType: .string)
        
        VimEngine.shared.lastYankStyle = .linewise
        let finalElement = sendMoveThroughVimEngineAndGetBackUpdatedFocusedElement()
        
        XCTAssertEqual(finalElement?.value, """
this should paste
after a new line and
not add a linefeed

test 3 of The 3 Cases for TextArea linewise
"""
        )
        XCTAssertEqual(finalElement?.caretLocation, 101)
    }
    
}


// linewise
// other cases
extension UIAS_p_TextViews_Tests {
    
    func test_that_in_normal_setting_it_pasts_the_content_on_a_new_line_below() {
        let textInAXFocusedElement = """
we gonna linewise paste
on a line that is not
the last so there's already
a linefeed at the end of the line
"""
        app.textViews.firstMatch.tap()
        app.textViews.firstMatch.typeText(textInAXFocusedElement)
        app.textViews.firstMatch.typeKey(.upArrow, modifierFlags: [])
        app.textViews.firstMatch.typeKey(.leftArrow, modifierFlags: [.option])
        app.textViews.firstMatch.typeKey(.leftArrow, modifierFlags: [])
        
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString("should paste that somewhere\n", forType: .string)
        
        VimEngine.shared.lastYankStyle = .linewise
        let finalElement = sendMoveThroughVimEngineAndGetBackUpdatedFocusedElement()
        
        XCTAssertEqual(finalElement?.value, """
we gonna linewise paste
on a line that is not
the last so there's already
should paste that somewhere
a linefeed at the end of the line
"""
        )
        XCTAssertEqual(finalElement?.caretLocation, 74)
        
    }
    
    func test_that_if_the_last_linewise_yanked_line_did_not_have_a_linefeed_pasting_it_will_add_the_linefeed_if_we_are_not_on_the_last_line() {
        let textInAXFocusedElement = """
when we yank the last line it doesn't contain
a linefeed but a linefeed should be pasted
if we are not pasting on the last line
"""
        app.textViews.firstMatch.tap()
        app.textViews.firstMatch.typeText(textInAXFocusedElement)
        app.textViews.firstMatch.typeKey(.upArrow, modifierFlags: [])
        app.textViews.firstMatch.typeKey(.leftArrow, modifierFlags: [.option])
        app.textViews.firstMatch.typeKey(.leftArrow, modifierFlags: [])
        
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString("we pasted the last line so no linefeed", forType: .string)
        
        VimEngine.shared.lastYankStyle = .linewise
        let finalElement = sendMoveThroughVimEngineAndGetBackUpdatedFocusedElement()
        
        XCTAssertEqual(finalElement?.value, """
when we yank the last line it doesn't contain
a linefeed but a linefeed should be pasted
we pasted the last line so no linefeed
if we are not pasting on the last line
"""
        )
        XCTAssertEqual(finalElement?.caretLocation, 89)
        
    }
    
    func test_that_if_on_last_line_and_the_last_yanking_style_was_linewise_it_pastes_the_content_on_a_new_line_below_without_an_ending_linefeed() {
        let textInAXFocusedElement = """
now we gonna linewise paste
after the last line
so we need to add the linefeed
ourselves
"""
        app.textViews.firstMatch.tap()
        app.textViews.firstMatch.typeText(textInAXFocusedElement)
        app.textViews.firstMatch.typeKey(.leftArrow, modifierFlags: [])
        
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString("new line to paste after last line\n", forType: .string)
        
        VimEngine.shared.lastYankStyle = .linewise
        let finalElement = sendMoveThroughVimEngineAndGetBackUpdatedFocusedElement()
        
        XCTAssertEqual(finalElement?.value, """
now we gonna linewise paste
after the last line
so we need to add the linefeed
ourselves
new line to paste after last line
"""
        )
        XCTAssertEqual(finalElement?.caretLocation, 89)
    }
    
    func test_that_if_on_the_last_line_and_the_last_yanking_style_was_linewise_it_pastes_the_content_on_a_new_line_below_without_an_ending_linefeed() {
        
    }
    
}