class FTZTextInputWithLoggerView: RCTSinglelineTextInputView, UITextFieldDelegate {
    
    var textField: UITextField?
    
    override init(bridge: RCTBridge) {
        super.init(bridge: bridge)
        (self.backedTextInputView as! UITextField).inputView = FTZCustomInputView();
    }
    
    override func didMoveToSuperview() {
        textField = self.backedTextInputView as? UITextField
        textField?.delegate = self;
    }
    
    // MARK: - UITextFieldDelegate
    
    @objc var onFocus: RCTBubblingEventBlock?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        DispatchQueue.main.async {
            textField.selectAll(nil);
        }
    }
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
