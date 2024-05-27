//
//  DetailsViewController.swift
//  mars
//
//  Created by mars uzhanov on 28.03.2024.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var book: Books.Items?
    
    //MARK: - Private properties
    private lazy var bookCover: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .red
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .center
        label.backgroundColor = .red
        return label
    }()
    
    private lazy var bookDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        return label
    }()
    
    private lazy var bookPriceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var siteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show in site", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .gray
        return button
    }()
    
    @objc func buttonPressed(sender: UIButton){
        print("button pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "About Book"
        setupUI()
        setupProperties()
    }
    
    //MARK: - Setup properties
    func setupProperties() {
        if let httpsURLString = book?.volumeInfo.imageLinks?.smallThumbnail?.replacingOccurrences(of: "http://", with: "https://"),
           let httpsURL = URL(string: httpsURLString) {
            bookCover.kf.setImage(with: httpsURL)
        } else {
            bookCover.image = UIImage(systemName: "person.fill.questionmark")
        }
        bookTitleLabel.text = book?.volumeInfo.title
        if let authors = book?.volumeInfo.authors {
            var authorsString = ""
                for author in authors {
                    authorsString += "\(author), "
                }
                if !authorsString.isEmpty {
                    authorsString = String(authorsString.dropLast(2))
                } else {
                    authorsString = "N/A"
                }
                bookAuthorLabel.text = "Authors: \(authorsString)"
        }
        bookDescriptionLabel.text = book?.volumeInfo.description
        bookPriceLabel.text = book?.saleInfo.saleability
    }
    
}

//MARK: - Private methods
private extension DetailsViewController {
    
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(bookCover)
        view.addSubview(bookTitleLabel)
        view.addSubview(bookAuthorLabel)
        view.addSubview(bookDescriptionLabel)
        view.addSubview(bookPriceLabel)
        view.addSubview(siteButton)
    }
    
    func setupConstraints() {
        bookCover.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(20)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        bookTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(bookCover.snp.trailing).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        bookAuthorLabel.snp.makeConstraints { make in
            make.leading.equalTo(bookCover.snp.trailing).offset(20)
            make.top.equalTo(bookTitleLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(20)
            
        }
        bookDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(bookCover.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        siteButton.snp.makeConstraints { make in
            make.top.equalTo(bookDescriptionLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        bookPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(siteButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
    }
    
}
