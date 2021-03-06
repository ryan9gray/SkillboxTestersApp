//
//  FeedViewController.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 13.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet internal var tableView: UITableView!
    var items: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    struct Output {
        var priductTap: (Product) -> Void
    }
    var output: Output!
    struct Input {
        var getItems: (_ completion: @escaping ([Product]) -> Void) -> Void
    }
    var input: Input!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        fetchItems()
    }

    func fetchItems() {
        input.getItems { [weak self] products in
            self?.items = products
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cells: [ProductTableViewCell.self])
		let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.5))
		tableFooterView.backgroundColor = .clear
		tableView.tableFooterView = tableFooterView
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        output.priductTap(item)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: ProductTableViewCell.self, for: indexPath)
        let item = items[indexPath.row]
        cell.set(
            title: item.title <~ Style.TextAttributes.regular,
            subtitle: item.price <~ Style.TextAttributes.regular,
            imageUrl: item.imageUrl
        )
        return cell
    }
}
