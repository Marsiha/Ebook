//
//  BooksTableViewCell.swift
//  mars
//
//  Created by mars uzhanov on 14.03.2024.
//

import UIKit
import SnapKit
import Kingfisher

class BooksTableViewCell: UITableViewCell {
    
    func configure(with result: Books.Items) {
        cellTextLabel.text = result.volumeInfo.title
        DispatchQueue.main.async {
            if let httpsURLString = result.volumeInfo.imageLinks?.smallThumbnail?.replacingOccurrences(of: "http://", with: "https://"),
               let httpsURL = URL(string: httpsURLString) {
                self.bookImageView.kf.setImage(with: httpsURL)
            } else {
                self.bookImageView.image = UIImage(systemName: "person.fill.questionmark")
            }
        }
    }
    
    private lazy var bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var cellTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension BooksTableViewCell {
    
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(cellTextLabel)
        addSubview(bookImageView)
    }
    
    func setupConstraints() {
        cellTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalTo(bookImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        bookImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
        }
    }
    
}
