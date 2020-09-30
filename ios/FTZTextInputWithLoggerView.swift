class FTZTextInputWithLoggerView: RCTSinglelineTextInputView,
UITextFieldDelegate, FTZCustomInputViewDelegate {

    weak var textField: UITextField?
    var customInputView: FTZCustomInputView?

    override init(bridge: RCTBridge) {
        super.init(bridge: bridge)
        let textInputView = self.backedTextInputView as! UITextField

        customInputView = FTZCustomInputView(targetTextField: textInputView);
        customInputView!.delegate = self
        textInputView.inputView = customInputView
    }

    override func didMoveToSuperview() {
        textField = self.backedTextInputView as? UITextField
        textField?.delegate = self;
    }

    @objc func setIsLeftButtonDisabled(_ val: ObjCBool) {
        customInputView?.leftButton?.isEnabled = !val.boolValue
    }

    @objc func setIsRightButtonDisabled(_ val: ObjCBool) {
        customInputView?.rightButton?.isEnabled = !val.boolValue
    }

    @objc func setStepValue(_ val: NSNumber) {
        let stepValue = val.doubleValue
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        let label = formatter.string(from: val)
        if (label == nil) {
            return
        }
        customInputView?.incrementButton?.value = stepValue;
        customInputView?.incrementButton?.setTitle("+" + label!, for: .normal)
        customInputView?.decrementButton?.value = -1 * stepValue;
        customInputView?.decrementButton?.setTitle("-" + label!, for: .normal)
    }

    @objc func setSuggestLabel(_ val: NSString) {
        customInputView?.suggestLabel?.text = val as String
    }

    @objc func setSuggestValue(_ val: NSNumber) {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        let label = formatter.string(from: val)
        customInputView?.suggestButton?.isEnabled = true
        customInputView?.unitLabel?.isEnabled = true
        customInputView?.suggestButton?.setTitle(label, for: .normal)
    }

    @objc func setUnitLabel(_ val: NSString) {
        customInputView?.unitLabel?.text = val as String
    }

    // MARK: - UITextFieldDelegate

    @objc var onFocus: RCTDirectEventBlock?
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if onFocus != nil {
            onFocus!(nil)
        }
        DispatchQueue.main.async {
            textField.selectAll(nil);
        }
    }

    @objc var onBlur: RCTDirectEventBlock?
    func textFieldDidEndEditing(_ textField: UITextField) {
        if onBlur != nil {
            onBlur!(nil)
        }
    }

    // MARK: - FTZCustomInputViewDelegate

    @objc var onLeftButtonPress: RCTDirectEventBlock?
    func leftButtonPressed() {
        if onLeftButtonPress != nil {
            onLeftButtonPress!(nil)
        }
    }

    @objc var onRightButtonPress: RCTDirectEventBlock?
    func rightButtonPressed() {
        if onRightButtonPress != nil {
            onRightButtonPress!(nil)
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
