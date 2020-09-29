class FTZCustomInputView : UIView {

    weak var target: UITextField?
    var safeAreaView: UIView?
    var bundle: Bundle
    var primary = UIColor(red: 0.29, green: 0.455, blue: 0.863, alpha: 1)
    var gray5 = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
    var gray10 = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)

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

    lazy var plusMinusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus.slash.minus", in: bundle, compatibleWith: nil), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.imageView!.contentMode = .scaleAspectFit
        button.tintColor = primary
        button.addTarget(self, action: #selector(handlePressPlusMinus), for: .touchUpInside)
        return button
    }()

    lazy var chevronDownButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "chevron.down", in: bundle, compatibleWith: nil), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.imageView!.contentMode = .scaleAspectFit
        button.tintColor = primary
        button.addTarget(self, action: #selector(handlePressChevronDown), for: .touchUpInside)
        return button
    }()

    lazy var backspaceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "delete.left.fill", in: bundle, compatibleWith: nil), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.imageView!.contentMode = .scaleAspectFit
        button.tintColor = primary
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
        return button
    }()

    func createKeyButton(key: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(key, for: .normal)
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(handlePressKey), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        return button
    }

    func initLayout() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = gray10

        safeAreaView = UIView()
        addSubview(safeAreaView!)
        safeAreaView?.translatesAutoresizingMaskIntoConstraints = false

        let topbarView = UIView()
        safeAreaView?.addSubview(topbarView)
        topbarView.translatesAutoresizingMaskIntoConstraints = false
        topbarView.backgroundColor = gray5
        topbarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        topbarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        topbarView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        topbarView.heightAnchor.constraint(equalToConstant: 36).isActive = true

        topbarView.addSubview(plusMinusButton)
        plusMinusButton.translatesAutoresizingMaskIntoConstraints = false
        plusMinusButton.leadingAnchor.constraint(equalTo: topbarView.leadingAnchor, constant: 5).isActive = true
        plusMinusButton.centerYAnchor.constraint(equalTo: topbarView.centerYAnchor, constant: 0).isActive = true
        plusMinusButton.heightAnchor.constraint(equalToConstant: 26).isActive = true

        topbarView.addSubview(chevronDownButton)
        chevronDownButton.translatesAutoresizingMaskIntoConstraints = false
        chevronDownButton.trailingAnchor.constraint(equalTo: topbarView.trailingAnchor, constant: -5).isActive = true
        chevronDownButton.centerYAnchor.constraint(equalTo: topbarView.centerYAnchor, constant: 0).isActive = true
        chevronDownButton.heightAnchor.constraint(equalToConstant: 26).isActive = true

        let mainView = UIView()
        safeAreaView?.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.leadingAnchor.constraint(equalTo: safeAreaView!.leadingAnchor, constant: 0).isActive = true
        mainView.trailingAnchor.constraint(equalTo: safeAreaView!.trailingAnchor, constant: 0).isActive = true
        mainView.topAnchor.constraint(equalTo: topbarView.bottomAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: safeAreaView!.bottomAnchor, constant: 0).isActive = true
        mainView.backgroundColor = gray10

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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
