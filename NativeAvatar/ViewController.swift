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
    private let imageBottomMargin: CGFloat = 8
    private let navBarHeightSmallState: CGFloat = 44
    private let navBarHeightLargeState: CGFloat = 96.5

    private let imageView: UIImageView = {
        let view = UIImageView()
        let image = UIImage(systemName: "person.crop.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        view.image = image
        view.tintColor = .systemGray
        return view
    }()
    private var imageViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        configureScrollView()
        configureNavBar()
    }
    
    private func configureScrollView() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
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
        guard let navigationBar = navigationController?.navigationBar else { return }

        navigationBar.prefersLargeTitles = true
        title = "Avatar"

        navigationBar.addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.contentMode = .bottom
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: imageSize)
        NSLayoutConstraint.activate([
            imageView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -imageRightMargin),
            imageView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -imageBottomMargin),
            imageViewHeightConstraint,
        ])
    }
    
    private func resizeImage(for navBarHeight: CGFloat) {
        let coeff: CGFloat = (navBarHeight - navBarHeightSmallState) / (navBarHeightLargeState - navBarHeightSmallState)
        imageViewHeightConstraint.constant = imageSize * min(1.0, coeff)
    }

}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let navBarHeight = navigationController?.navigationBar.frame.height else { return }
        resizeImage(for: navBarHeight)
    }
}
