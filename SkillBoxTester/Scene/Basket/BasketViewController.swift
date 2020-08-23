//
//  BasketViewController.swift
//  SkillBoxTester
//
//  Created by Evgeny Ivanov on 13.08.2020.
//  Copyright © 2020 Evgeny Ivanov. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {

    @IBOutlet internal var tableView: UITableView!
    var items: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var count: Double = 0.0
    @IBOutlet var totalCostLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        calculate()
    }

    func calculate() {
        guard let products = Basket.current?.products else { return }
        items = Array(products.keys)

        count = items.reduce(0.0, {
            $0 + Double($1.price)! * Double((products[$1] ?? 1))
        })
        totalCostLabel.text = count.stringValue
    }

    func recalculate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.calculate()
        }
    }

    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cells: [BusketTableViewCell.self])
		let tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.5))
		tableFooterView.backgroundColor = .clear
		tableView.tableFooterView = tableFooterView
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: BusketTableViewCell.self, for: indexPath)
        let item = items[indexPath.row]
        cell.set(
            title: item.title <~ Style.TextAttributes.regular,
            subtitle: item.price <~ Style.TextAttributes.regular,
            imageUrl: item.imageUrl,
            count: Basket.current?.count(of: item) ?? 1
        )
        cell.output = .init(plus: { [weak self] in
            Basket.current?.addToCart(item)
            self?.recalculate()
        }, minus: { [weak self] in
            Basket.current?.remove(item)
            self?.recalculate()
        })
        
        return cell
    }
}
