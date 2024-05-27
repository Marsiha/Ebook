//
//  CategoryCollectionViewCell.swift
//  mars
//
//  Created by mars uzhanov on 11.05.2024.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    func configure() {
        setupUI()
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "mars"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CategoryCollectionViewCell {
    
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        contentView.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
