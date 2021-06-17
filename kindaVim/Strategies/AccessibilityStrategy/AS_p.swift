import AppKit

extension AccessibilityStrategy {
    
    func p(on element: AccessibilityTextElement?) -> AccessibilityTextElement? {
        guard let element = element else { return nil }
        
        if element.role == .textField {
            return pForTextFields(on: element)
        }
        
        if element.role == .textArea {
            return pForTextAreas(on: element)
        }        
        
        return element         
    }
    
    private func pForTextFields(on element: AccessibilityTextElement) -> AccessibilityTextElement {
        var element = element
        
        if element.isEmpty {
            element.selectedText = NSPasteboard.general.string(forType: .string)
            
            return element
        }
        
        if element.caretIsAtTheEnd, element.lastCharacterIsNotLinefeed {
            return element
        }
        
                
        var textToPaste = NSPasteboard.general.string(forType: .string) ?? ""

        if textToPaste.hasSuffix("\n") {
            textToPaste.removeLast()
        }

        element.caretLocation += 1        
        element.selectedText = textToPaste
                    
        return element
    }
    
    private func pForTextAreas(on element: AccessibilityTextElement) -> AccessibilityTextElement {
        let element = element
        
        if VimEngine.shared.lastYankStyle == .characterwise {
            return pForTextAreasCharacterwise(on: element)
        }
        
        if VimEngine.shared.lastYankStyle == .linewise {
            return pForTextAreasLinewise(on: element)
        }
        
        return element
    }
    
    private func pForTextAreasCharacterwise(on element: AccessibilityTextElement) -> AccessibilityTextElement {
        var element = element
                
        if element.isEmpty {
            element.selectedText = NSPasteboard.general.string(forType: .string)
            
            return element
        }
        
        if element.caretIsAtTheEnd, element.lastCharacterIsNotLinefeed {
            return element
        }
        
        if element.caretIsAtTheEnd, element.lastCharacterIsLinefeed {
            element.selectedText = NSPasteboard.general.string(forType: .string)
            
            return element
        }
        
        
        if element.currentLine.isNotAnEmptyLine {
            element.caretLocation += 1
        }
        
        element.selectedText = NSPasteboard.general.string(forType: .string)
        
        return element
    }
    
    private func pForTextAreasLinewise(on element: AccessibilityTextElement) -> AccessibilityTextElement {
        var element = element
        
        if element.isEmpty {
            element.selectedText = "\n" + (NSPasteboard.general.string(forType: .string) ?? "")
            
            return element
        }
        
        if element.caretIsAtTheEnd, element.lastCharacterIsNotLinefeed {
            return element
        }
        
        if element.caretIsAtTheEnd, element.lastCharacterIsLinefeed {
            var textToPaste = NSPasteboard.general.string(forType: .string) ?? ""
            
            if textToPaste.hasSuffix("\n") {
                textToPaste.removeLast()
            }
            
            element.selectedText = "\n" + textToPaste
            
            return element
        }
        
        
        var textToPaste: String
           
        if element.currentLine.isTheLastLine {
            textToPaste = "\n" + (NSPasteboard.general.string(forType: .string) ?? "")
            
            if textToPaste.hasSuffix("\n") {
                textToPaste.removeLast()
            }            
        } else {
            textToPaste = NSPasteboard.general.string(forType: .string) ?? ""
            
            if !textToPaste.hasSuffix("\n") {
                textToPaste.append("\n")
            }
        }
        
        element.caretLocation = element.currentLine.end!
        element.selectedLength = 0
        element.selectedText = textToPaste
        
        _ = AccessibilityTextElementAdaptor.toAXfocusedElement(from: element)
        
        element.caretLocation += 1
        element.selectedText = nil
        
        return element    
    }
    
}