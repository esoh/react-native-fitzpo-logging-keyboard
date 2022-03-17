protocol FTZCustomInputViewDelegate {
    // protocol definition goes here
    func leftButtonPressed()
    func rightButtonPressed()
}

class ValuedButton: UIButton {
    var value: Double = 0
}

class FTZCustomInputView : UIView {

    weak var target: UITextField?
    var delegate: FTZCustomInputViewDelegate?
    var suggestLabel: UILabel? // TODO implement with default ""
    var suggestButton: UIButton? // TODO implement with default "-" disabled
    var unitLabel: UILabel? // TODO implement with default ""
    var safeAreaView: UIView?
    var topBarView: UIView?
    var leftButton: UIButton?
    var rightButton: UIButton?
    var decrementButton: ValuedButton?
    var incrementButton: ValuedButton?
    var bundle: Bundle
    var primaryColor = UIColor(red: 0.29, green: 0.455, blue: 0.863, alpha: 1)
    var topBarBackgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    var keyboardBackgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    var textMutedColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    var normalButtons: Array<UIButton> = Array()

    init(targetTextField: UITextField) {
        target = targetTextField
        let resourcePath = Bundle.main.path(
            forResource: "Resources",
            ofType: "bundle"
        )!
        bundle = Bundle(path: resourcePath)!
        super.init(frame: .zero)
        initLayout()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        let margins = layoutMarginsGuide
        safeAreaView?.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        safeAreaView?.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        safeAreaView?.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0).isActive = true
        safeAreaView?.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
    }

    @objc func handlePressChevronDown() {
        target?.resignFirstResponder()
    }

    @objc func handlePressPrev() {
        delegate?.leftButtonPressed()
    }

    @objc func handlePressNext() {
        delegate?.rightButtonPressed()
    }

    @objc func handlePressPlusMinus() {
        let number = getNumberFromText(text: target?.text)
        if(number == nil){
            return
        }

        let hasDecimal = target?.text!.contains(".") ?? false
        if (!hasDecimal) {
            target?.text = String(Int(-number!))
        } else {
            target?.text = String(-number!)
        }
        target?.sendActions(for: .editingChanged)
    }

    @objc func handlePressKey(sender: UIButton) {
        let replacementString = sender.title(for: .normal)!

        if let range = target?.selectedTextRange {
            let location = target!.offset(from: target!.beginningOfDocument, to: range.start)
            let length = target!.offset(from: range.start, to: range.end)
            let range = Range(NSRange(location: location, length: length), in: target!.text!)!

            let updatedText = target!.text!.replacingCharacters(in: range, with: replacementString)
            if (updatedText.filter { $0 == "." }.count > 1) {
                return
            }
        }
        target?.insertText(replacementString)
    }

    @objc func handlePressSuggest(sender: UIButton) {
        target?.text = sender.title(for: .normal)
        target?.sendActions(for: .editingChanged)
    }

    func formatAsString(_ val: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        return formatter.string(from: NSNumber(value: val))!
    }

    @objc func handlePressStep(sender: ValuedButton) {
        let number = getNumberFromText(text: target?.text) ?? 0;

        target?.text = formatAsString(number + sender.value)
        target?.sendActions(for: .editingChanged)
    }

    @objc func handlePressBackspace() {
        target?.deleteBackward()
    }

    func getNumberFromText(text: String?) -> Double? {
        if let cost = Double(text!) {
            return cost
        } else {
            return nil
        }
    }

    func setPrimaryColor(val: UIColor) {
        leftButton?.tintColor = val
        rightButton?.tintColor = val
        backspaceButton.tintColor = val
        chevronDownButton.tintColor = val
        plusMinusButton.tintColor = val
    }

    func setTopBarBackgroundColor(val: UIColor) {
        topBarView?.backgroundColor = val
    }

    func setTextColor(val: UIColor) {
        for button in normalButtons {
            button.tintColor = val
        }
        decimalButton.tintColor = val
    }

    lazy var plusMinusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus.slash.minus", in: bundle, compatibleWith: nil), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.imageView!.contentMode = .scaleAspectFit
        button.tintColor = primaryColor
        button.addTarget(self, action: #selector(handlePressPlusMinus), for: .touchUpInside)
        return button
    }()

    lazy var chevronDownButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "chevron.down", in: bundle, compatibleWith: nil), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.imageView!.contentMode = .scaleAspectFit
        button.tintColor = primaryColor
        button.addTarget(self, action: #selector(handlePressChevronDown), for: .touchUpInside)
        return button
    }()

    lazy var backspaceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "delete.left.fill", in: bundle, compatibleWith: nil), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.imageView!.contentMode = .scaleAspectFit
        button.tintColor = primaryColor
        button.addTarget(self, action: #selector(handlePressBackspace), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        return button
    }()

    lazy var decimalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(".", for: .normal)
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(handlePressKey), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        normalButtons.append(button)
        return button
    }()

    func createLeftButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "arrow.left", in: bundle, compatibleWith: nil), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.imageView!.contentMode = .scaleAspectFit
        button.tintColor = primaryColor
        button.addTarget(self, action: #selector(handlePressPrev), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }

    func createRightButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "arrow.right", in: bundle, compatibleWith: nil), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.imageView!.contentMode = .scaleAspectFit
        button.tintColor = primaryColor
        button.addTarget(self, action: #selector(handlePressNext), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }

    func createDecrementButton() -> ValuedButton {
        let button = ValuedButton(type: .system)
        button.value = -1
        button.setTitle("-1", for: .normal)
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(handlePressStep), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        normalButtons.append(button)
        return button
    }

    func createIncrementButton() -> ValuedButton {
        let button = ValuedButton(type: .system)
        button.value = 1
        button.setTitle("+1", for: .normal)
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(handlePressStep), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        normalButtons.append(button)
        return button
    }

    func createKeyButton(key: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(key, for: .normal)
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(handlePressKey), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        normalButtons.append(button)
        return button
    }

    func createSuggestButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.tintColor = UIColor.black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePressSuggest), for: .touchUpInside)
        button.isEnabled = false
        normalButtons.append(button)
        return button
    }

    func initLayout() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = keyboardBackgroundColor

        safeAreaView = UIView()
        addSubview(safeAreaView!)
        safeAreaView?.translatesAutoresizingMaskIntoConstraints = false

        let topBarViewInternal = UIView()
        topBarView = topBarViewInternal
        safeAreaView?.addSubview(topBarViewInternal)
        topBarViewInternal.translatesAutoresizingMaskIntoConstraints = false
        topBarViewInternal.backgroundColor = topBarBackgroundColor
        topBarViewInternal.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        topBarViewInternal.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        topBarViewInternal.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        topBarViewInternal.heightAnchor.constraint(equalToConstant: 36).isActive = true

        topBarViewInternal.addSubview(plusMinusButton)
        plusMinusButton.translatesAutoresizingMaskIntoConstraints = false
        plusMinusButton.leadingAnchor.constraint(equalTo: topBarViewInternal.leadingAnchor, constant: 5).isActive = true
        plusMinusButton.centerYAnchor.constraint(equalTo: topBarViewInternal.centerYAnchor, constant: 0).isActive = true
        plusMinusButton.heightAnchor.constraint(equalToConstant: 26).isActive = true

        topBarViewInternal.addSubview(chevronDownButton)
        chevronDownButton.translatesAutoresizingMaskIntoConstraints = false
        chevronDownButton.trailingAnchor.constraint(equalTo: topBarViewInternal.trailingAnchor, constant: -5).isActive = true
        chevronDownButton.centerYAnchor.constraint(equalTo: topBarViewInternal.centerYAnchor, constant: 0).isActive = true
        chevronDownButton.heightAnchor.constraint(equalToConstant: 26).isActive = true

        let mainView = UIView()
        safeAreaView?.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.leadingAnchor.constraint(equalTo: safeAreaView!.leadingAnchor, constant: 0).isActive = true
        mainView.trailingAnchor.constraint(equalTo: safeAreaView!.trailingAnchor, constant: 0).isActive = true
        mainView.topAnchor.constraint(equalTo: topBarViewInternal.bottomAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: safeAreaView!.bottomAnchor, constant: 0).isActive = true

        let keypadView = UIStackView()
        mainView.addSubview(keypadView)
        keypadView.translatesAutoresizingMaskIntoConstraints = false
        keypadView.axis = .horizontal
        keypadView.alignment = .fill
        keypadView.distribution = .fillEqually
        keypadView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0).isActive = true
        keypadView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true
        keypadView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0).isActive = true
        keypadView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.64).isActive = true

        let firstColView = UIStackView()
        keypadView.addArrangedSubview(firstColView)
        firstColView.axis = .vertical
        firstColView.alignment = .fill
        firstColView.distribution = .equalSpacing
        for key in ["1", "4", "7"] {
            firstColView.addArrangedSubview(createKeyButton(key: key))
        }
        firstColView.addArrangedSubview(decimalButton)

        let secondColView = UIStackView()
        keypadView.addArrangedSubview(secondColView)
        secondColView.axis = .vertical
        secondColView.alignment = .fill
        secondColView.distribution = .equalSpacing

        for key in ["2", "5", "8", "0"] {
            secondColView.addArrangedSubview(createKeyButton(key: key))
        }

        let thirdColView = UIStackView()
        keypadView.addArrangedSubview(thirdColView)
        thirdColView.axis = .vertical
        thirdColView.alignment = .fill
        thirdColView.distribution = .equalSpacing

        for key in ["3", "6", "9"] {
            thirdColView.addArrangedSubview(createKeyButton(key: key))
        }
        thirdColView.addArrangedSubview(backspaceButton)

        let sideView = UIStackView()
        mainView.addSubview(sideView)
        sideView.translatesAutoresizingMaskIntoConstraints = false
        sideView.axis = .vertical
        sideView.alignment = .fill
        sideView.distribution = .fillEqually
        sideView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0).isActive = true
        sideView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true
        sideView.leadingAnchor.constraint(equalTo: keypadView.trailingAnchor, constant: 0).isActive = true
        sideView.trailingAnchor.constraint(equalTo: safeAreaView!.trailingAnchor, constant: 0).isActive = true

        let suggestView = UIView()
        sideView.addArrangedSubview(suggestView)
        suggestView.translatesAutoresizingMaskIntoConstraints = false

        suggestButton = createSuggestButton()
        suggestView.addSubview(suggestButton!)
        suggestButton!.centerXAnchor.constraint(equalTo: suggestView.centerXAnchor, constant: 0).isActive = true
        suggestButton!.centerYAnchor.constraint(equalTo: suggestView.centerYAnchor, constant: 10).isActive = true
        suggestButton!.heightAnchor.constraint(equalToConstant: 30).isActive = true

        suggestLabel = UILabel()
        suggestView.addSubview(suggestLabel!)
        suggestLabel!.translatesAutoresizingMaskIntoConstraints = false
        suggestLabel!.centerXAnchor.constraint(equalTo: suggestView.centerXAnchor, constant: 0).isActive = true
        suggestLabel!.bottomAnchor.constraint(equalTo: suggestButton!.topAnchor, constant: 0).isActive = true
        suggestLabel!.font = UIFont.systemFont(ofSize: 12)
        suggestLabel!.textColor = textMutedColor

        unitLabel = UILabel()
        suggestView.addSubview(unitLabel!)
        unitLabel!.translatesAutoresizingMaskIntoConstraints = false
        unitLabel!.leadingAnchor.constraint(equalTo: suggestButton!.trailingAnchor, constant: 0).isActive = true
        unitLabel!.lastBaselineAnchor.constraint(equalTo: suggestButton!.lastBaselineAnchor, constant: 0).isActive = true
        unitLabel!.isEnabled = false
        unitLabel!.font = UIFont.boldSystemFont(ofSize: 14)

        let sideButtonsView = UIStackView()
        sideView.addArrangedSubview(sideButtonsView)
        sideButtonsView.translatesAutoresizingMaskIntoConstraints = false
        sideButtonsView.axis = .vertical
        sideButtonsView.alignment = .fill
        sideButtonsView.distribution = .fillEqually

        let incDecButtonsView = UIStackView()
        sideButtonsView.addArrangedSubview(incDecButtonsView)
        incDecButtonsView.translatesAutoresizingMaskIntoConstraints = false
        incDecButtonsView.axis = .horizontal
        incDecButtonsView.alignment = .fill
        incDecButtonsView.distribution = .equalSpacing

        decrementButton = createDecrementButton()
        incrementButton = createIncrementButton()
        incDecButtonsView.addArrangedSubview(decrementButton!)
        incDecButtonsView.addArrangedSubview(incrementButton!)
        incDecButtonsView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        incDecButtonsView.isLayoutMarginsRelativeArrangement = true

        let prevNextButtonsView = UIStackView()
        sideButtonsView.addArrangedSubview(prevNextButtonsView)
        prevNextButtonsView.translatesAutoresizingMaskIntoConstraints = false
        prevNextButtonsView.axis = .horizontal
        prevNextButtonsView.alignment = .fill
        prevNextButtonsView.distribution = .equalSpacing
        prevNextButtonsView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        prevNextButtonsView.isLayoutMarginsRelativeArrangement = true

        leftButton = createLeftButton()
        rightButton = createRightButton()
        prevNextButtonsView.addArrangedSubview(leftButton!)
        prevNextButtonsView.addArrangedSubview(rightButton!)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

