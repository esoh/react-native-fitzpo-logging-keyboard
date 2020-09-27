class FTZTextInputWithLoggerView: RCTSinglelineTextInputView {
}

@objc (FTZTextInputWithLoggerManager)
class FTZTextInputWithLoggerManager: RCTSinglelineTextInputViewManager {
 
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
 
  override func view() -> UIView! {
    return FTZTextInputWithLoggerView(bridge: self.bridge)
  }
 
}
