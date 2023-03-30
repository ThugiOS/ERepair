//
//  TapBarController.swift
//  ERepair
//
//  Created by Никитин Артем on 30.03.23.
//

import UIKit

/*
 UITabBarController включает в себя массив с ВьюКонтороллерами, между которыми
 мы можем переключаться используя ТапБар
 */


class MainTapBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTapBarBackground()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: HomeViewController(),
                title: "Person",
                image: UIImage(systemName: "scooter")
            ),
            generateVC(
                viewController: CatalogViewController(),
                title: "Prices",
                image: UIImage(systemName: "magazine.fill")
            ),
            generateVC(
                viewController: MapViewController(),
                title: "Map",
                image: UIImage(systemName: "map")
            )
        ]
    }
    
    // настройка иконки тапбара
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    // настройка фона тапбара
    // можно просто изменить цвет фона tabBar.backgroundColor = .systemGray
    private func setTapBarBackground() {
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
        // помещаем созданный слой на тапбар
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        // ширина элементов тапбара
        tabBar.itemWidth = width / 5
        // разместим элементы по центру
        tabBar.itemPositioning = .centered

        roundLayer.fillColor = UIColor.main.cgColor
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
        
    }
}
