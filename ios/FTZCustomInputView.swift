class FTZCustomInputView : UIView {

    weak var target: UITextField?
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

    @objc func handlePressChevronDown() {
        target?.resignFirstResponder()
    }

    @objc func handlePressPlusMinus() {
        let number = getNumberFromText(text: target?.text)
        if(number == nil){
            return;
        }

        let hasDecimal = target?.text!.contains(".") ?? false
        if (!hasDecimal) {
            target?.text = String(Int(-number!))
        } else {
            target?.text = String(-number!)
        }
        target?.sendActions(for: .editingChanged)
    }

    func getNumberFromText(text: String?) -> Double? {
        if let cost = Double(text!) {
            return cost;
        } else {
            return nil;
        }
    }

    lazy var plusMinusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus.slash.minus", in: bundle, compatibleWith: nil), for: .normal);
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.imageView!.contentMode = .scaleAspectFit;
        button.tintColor = primary
        button.addTarget(self, action: #selector(handlePressPlusMinus), for: .touchUpInside)
        return button
    }()

    lazy var chevronDownButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "chevron.down", in: bundle, compatibleWith: nil), for: .normal);
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.imageView!.contentMode = .scaleAspectFit;
        button.tintColor = primary
        button.addTarget(self, action: #selector(handlePressChevronDown), for: .touchUpInside)
        return button
    }()

    func initLayout() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundColor = gray10

        let topbarView = UIView();
        topbarView.frame.size.width = bounds.size.width
        topbarView.frame.size.height = 36
        topbarView.autoresizingMask = [.flexibleWidth]
        topbarView.backgroundColor = gray5
        addSubview(topbarView);

        topbarView.addSubview(plusMinusButton);
        plusMinusButton.translatesAutoresizingMaskIntoConstraints = false
        plusMinusButton.leadingAnchor.constraint(equalTo: topbarView.leadingAnchor, constant: 5).isActive = true
        plusMinusButton.centerYAnchor.constraint(equalTo: topbarView.centerYAnchor, constant: 0).isActive = true
        plusMinusButton.heightAnchor.constraint(equalToConstant: 26).isActive = true

        topbarView.addSubview(chevronDownButton);
        chevronDownButton.translatesAutoresizingMaskIntoConstraints = false
        chevronDownButton.trailingAnchor.constraint(equalTo: topbarView.trailingAnchor, constant: -5).isActive = true
        chevronDownButton.centerYAnchor.constraint(equalTo: topbarView.centerYAnchor, constant: 0).isActive = true
        chevronDownButton.heightAnchor.constraint(equalToConstant: 26).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/*
private extension FTZCustomInputView {
    func configure() {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addButtons()
    }

    func addButtons() {
        let stackView = createStackView(axis: .vertical)
        stackView.frame = bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(stackView)

        for row in 0 ..< 3 {
            let subStackView = createStackView(axis: .horizontal)
            stackView.addArrangedSubview(subStackView)

            for column in 0 ..< 3 {
                subStackView.addArrangedSubview(numericButtons[row * 3 + column + 1])
            }
        }

        let subStackView = createStackView(axis: .horizontal)
        stackView.addArrangedSubview(subStackView)

        let blank = UIView()
        blank.layer.borderWidth = 0.5
        blank.layer.borderColor = UIColor.darkGray.cgColor
        subStackView.addArrangedSubview(blank)

        subStackView.addArrangedSubview(numericButtons[0])
        subStackView.addArrangedSubview(deleteButton)
    }

    func createStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }
}
*/
