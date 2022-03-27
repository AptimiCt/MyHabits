//
//  UIView+Ext.swift
//  MyHabits
//
//  Created by Александр Востриков on 26.03.2022.
//

import UIKit

extension UIView {
    func toAutoLayout(){
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ subViews: UIView...){
        subViews.forEach { addSubview( $0 ) }
    }
    
    func pin(to superView: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
