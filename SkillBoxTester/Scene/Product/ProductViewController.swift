//
//  ProductViewController.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 22.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import UIKit
import Spring

class ProductViewController: UIViewController {

    @IBOutlet internal var tableView: UITableView!

    var comments: [Comment] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var commentTextView: DesignableTextView!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var toCartButton: UIButton!
    private let tableViewKeyboardBehavior = FormKeyboardBehavior()

    struct Input {
        let item: Product
        var getComments: (_ completion: @escaping ([Comment]) -> Void) -> Void
    }

    var input: Input!

    struct Output {
        var sendComment: (String) -> Void
        var addToCart: (Product) -> Void
    }
    var output: Output!

    @IBAction func sendCommentTap(_ sender: Any) {
        output.sendComment(commentTextView.text)
        commentTextView.text = ""
    }
    @IBAction func addToCartTap(_ sender: Any) {
        output.addToCart(input.item)
        let has = Basket.current?.inBusket(input.item) ?? false
        toCartButton.setTitle(has ? "delete".localized : "to_cart".localized, for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupProduct(input.item)
        input.getComments { [weak self] comments in
            self?.comments = comments
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableViewKeyboardBehavior.addKeyboardNotifications()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        tableViewKeyboardBehavior.removeKeyboardNotifications()
    }


    func setupProduct(_ product: Product) {
        imageView.setImageWithSD(from: product.imageUrl)
        titleLabel.text = product.title
        priceLabel.text = product.price
        infoLabel.text = product.info
        let has = Basket.current?.inBusket(product) ?? false
        toCartButton.setTitle(has ? "delete".localized : "to_cart".localized, for: .normal)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.sizeToFitTableHeaderView()
    }

    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cells: [CommentTableViewCell.self])
		let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.5))
		tableFooterView.backgroundColor = .clear
		tableView.tableFooterView = tableFooterView
        tableViewKeyboardBehavior.scrollView = tableView
    }

}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: CommentTableViewCell.self, for: indexPath)
        let item = comments[indexPath.row]
        cell.set(comment: item.text, author: item.userName)
        return cell
    }
}
