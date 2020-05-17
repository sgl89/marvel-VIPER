//
//  CommonRouterProtocol.swift
//  marvel
//
//  Created by Sonia Giraldez on 15/05/2020.
//  Copyright © 2020 Sonia Giraldez. All rights reserved.
//

import Foundation
import UIKit

//----------------------------
// MARK: - Navigation Types
//----------------------------
public enum NavigationRouterType {
    case push
    case pushAsFirst
    case present
    case presentWithNav
    case asRoot
    case asRootWithNav
}

//----------------------------
// MARK: - Base Router Protocols
//----------------------------
protocol BaseRouterProtocol : class {
    
    func push(from view: UIViewController?, to toView: UIViewController?)
    func pushAsFirst(from view: UIViewController?, to toView: UIViewController?)
    func present(from view: UIViewController?, to toView: UIViewController?)
    func pop(from view: UIViewController?)
    func popToRoot(from view: UIViewController?)
    func popToViewController(named: String, from view: UIViewController?)
    func dismiss(from view: UIViewController?)
    
    func startNavigation(navigationType: NavigationRouterType, view: UIViewController?, from: UIViewController?, completion: (() -> ())?)
    func startNavigation(navigationType: NavigationRouterType, view: UIViewController?, from: UIViewController?)
}

//----------------------------
// MARK: - Base Router Class
//----------------------------
class BaseRouter : BaseRouterProtocol {
    
    /**
     Push
     */
    public func push(from view: UIViewController?, to toView: UIViewController?) {
        if let toView = toView {
            view?.navigationController?.pushViewController(toView, animated: true)
        }
    }
    
    /**
     Push as first
     */
    public func pushAsFirst(from view: UIViewController?, to toView: UIViewController?) {
        if let toView = toView {
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            view?.navigationController?.view.layer.add(transition, forKey: nil)
            view?.navigationController?.viewControllers = [toView]
        }
    }
    
    /**
     present
     */
    public func present(from view: UIViewController?, to toView: UIViewController?) {
        if let toView = toView {
            view?.present(toView, animated: true)
        }
    }
    
    /**
     pop
     */
    public func pop(from view: UIViewController?) {
       view?.navigationController?.popViewController(animated: true)
    }
    
    /**
     pop to root
     */
    public func popToRoot(from view: UIViewController?) {
        view?.navigationController?.popToRootViewController(animated: true)
    }
    
    /**
     pop to viewcontroller named
     */
    public func popToViewController(named: String, from view: UIViewController?) {
        for vc in view?.navigationController?.viewControllers ?? [UIViewController]() {
            if String(describing: type(of: vc)) == named {
                view?.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    
    /**
     dismiss
     */
    public func dismiss(from view: UIViewController?) {
        view?.dismiss(animated: true, completion: nil)
    }

    /**
     Start navigation
     */
    public func startNavigation(navigationType: NavigationRouterType, view: UIViewController?, from: UIViewController? = nil) {
        startNavigation(navigationType: navigationType, view: view, from: from, completion: nil)
    }
    public func startNavigation(navigationType: NavigationRouterType, view: UIViewController?, from: UIViewController? = nil, completion: (() -> ())? = nil) {
        
        guard let view = view else { return }
        
        switch navigationType {
            
        case .push:
            from?.navigationController?.pushViewController(view, animated: true)
            break
            
        case .pushAsFirst:
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            from?.navigationController?.view.layer.add(transition, forKey: nil)
            from?.navigationController?.viewControllers = [view]
            break;
            
        case .present:
            from?.present(view, animated: true, completion: completion)
            break
            
        case .presentWithNav:
            from?.present(UINavigationController(rootViewController: view), animated: true, completion: completion)
            break
            
        case .asRoot:
            presentViewController(viewController: view, animated: true, completion: completion)
            break
            
        case .asRootWithNav:
            presentViewController(viewController: UINavigationController(rootViewController: view), animated: true, completion: completion)
            break
         
        }
    }
    
    private func presentViewController(viewController: UIViewController, animated: Bool, completion: (() -> ())? = nil) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let snapshot: UIView = (appDelegate.window?.snapshotView(afterScreenUpdates: true))!
            viewController.view.addSubview(snapshot)

            appDelegate.window?.rootViewController = viewController
            appDelegate.window?.makeKeyAndVisible()

            if animated {
                UIView.animate(withDuration: 0.3, animations: {() in
                    snapshot.layer.opacity = 0
                    snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
                }, completion: {(_: Bool) in
                    snapshot.removeFromSuperview()
                })
            }
        }
    }
}
