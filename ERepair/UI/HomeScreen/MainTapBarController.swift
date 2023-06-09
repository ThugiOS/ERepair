//
//  MainTapBarController.swift
//  ERepair
//
//  Created by Никитин Артем on 30.03.23.
//

import UIKit

class MainTapBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        generateTabBarUser()
        setTapBarBackground()
    }
    
    private func generateTabBarUser() {
        viewControllers = [
            generateVC(
                viewController: UserViewController(),
                title: "Главная",
                image: UIImage(systemName: "scooter")
            ),
            generateVC(
                viewController: CatalogViewController(),
                title: "Цены",
                image: UIImage(systemName: "magazine.fill")
            ),
            generateVC(
                viewController: MapViewController(),
                title: "Мы на карте",
                image: UIImage(systemName: "map")
            )
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }

    private func setTapBarBackground() {
        tabBar.backgroundColor = .none
        let positionX: CGFloat = 25.0
        let positionY: CGFloat = 5.0
        let width = tabBar.bounds.width - positionX * 2
        let height = tabBar.bounds.height + positionY * 2

        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(x: positionX, y: tabBar.bounds.minY - positionY, width: width, height: height),
            cornerRadius: height / 2
        )

        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered

        roundLayer.fillColor = UIColor.backgroundTapBar.cgColor
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
}
