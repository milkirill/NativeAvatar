//
//  ViewController.swift
//  NativeAvatar
//
//  Created by Kirill Milekhin on 23/09/2023.
//

import UIKit

final class ViewController: UIViewController {
    private let imageSize: CGFloat = 36
    private let imageRightMargin: CGFloat = 16
    private let titleText = "Avatar"

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "person.crop.circle.fill")
        view.tintColor = .systemGray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollView()
        configureNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureAvatar()
    }
    
    private func configureScrollView() {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1500)
    }
    
    private func configureNavBar() {
        title = titleText
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureAvatar() {
        guard let largeTitleView = navigationController?.navigationBar.subviews.first(where: { NSStringFromClass($0.classForCoder) == "_UINavigationBarLargeTitleView" }),
              let largeLabel = largeTitleView.subviews.first(where: { ($0 as? UILabel)?.text == titleText })
        else { return }
        
        largeTitleView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: largeTitleView.rightAnchor, constant: -imageRightMargin),
            imageView.centerYAnchor.constraint(equalTo: largeLabel.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageSize),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
        ])
    }
}
