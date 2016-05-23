//
//  UITableViewCell.swift
//  Pods
//
//  Created by Γιώργος Καϊμακάς on 18/05/16.
//
//

import Foundation
import UIKit

public extension UITableViewCell {
	public var tableView: UITableView? {
		var view = self.superview
		
		while view != nil && !(view?.isKindOfClass(UITableView))! {
			view = view?.superview
		}
		
		if let view = view as? UITableView {
			return view
		}
		
		return nil
	}
}
