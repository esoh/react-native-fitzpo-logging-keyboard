class FTZTextInputWithLoggerView: RCTSinglelineTextInputView, UITextFieldDelegate {

    weak var textField: UITextField?

    override init(bridge: RCTBridge) {
        super.init(bridge: bridge)
        let textInputView = self.backedTextInputView as! UITextField
        textInputView.inputView = FTZCustomInputView(targetTextField: textInputView);
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