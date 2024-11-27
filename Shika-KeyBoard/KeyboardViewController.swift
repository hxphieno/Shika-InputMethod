//
//  KeyboardViewController.swift
//  Shika-KeyBoard
//
//  Created by 分诺 on 2024/11/21.
//

import UIKit


class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    var keyButtonList:[UIButton]=[]
    let ButtonTitles=[["Q","W","E","R","T","Y","U","I","O","P"],
                      ["A","S","D","F","G","H","J","K","L"],
                      ["Z","X","C","V","B","N","M"]]
    func setUpKeyBoard(){
        let buttonHeight:CGFloat = 45
        let horizontalPadding:CGFloat=10
        let verticalPadding:CGFloat=5
        let buttonSpacing:CGFloat=5
        
        var previousRowBottom:CGFloat = 0
        for row in ButtonTitles{
            let stackView=UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .equalSpacing
            stackView.spacing = buttonSpacing
            
            var letterButtons:[UIButton]=[]
            for title in row{
                let button=UIButton(type: .system)
                button.setTitle(title, for: [])
                button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
                button.setTitleColor(UIColor.black, for: [])
                button.backgroundColor = UIColor.systemGray5
                button.layer.cornerRadius=5
                button.layer.masksToBounds=true
                button.translatesAutoresizingMaskIntoConstraints=false
                button.addTarget(self, action: #selector(letterButtonTapped(_:)), for: .touchUpInside)
                
                stackView.addArrangedSubview(button)
                letterButtons.append(button)
            }
            stackView.translatesAutoresizingMaskIntoConstraints=false
            self.view.addSubview(stackView)
            
            NSLayoutConstraint.activate([
                            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: horizontalPadding),
                            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -horizontalPadding),
                            stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: previousRowBottom + verticalPadding),
                            stackView.heightAnchor.constraint(equalToConstant: buttonHeight)
                        ])
                        
            previousRowBottom += buttonHeight + verticalPadding
        }
    }
    @objc func letterButtonTapped(_ sender:UIButton){
        let proxy=self.textDocumentProxy
        if let letter = sender.title(for: .normal){
            proxy.insertText(letter)
        }
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        setUpKeyBoard()
        // Add custom view sizing constraints here

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}
