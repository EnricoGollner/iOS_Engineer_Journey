//
//  ChatView.swift
//  MensageApp
//
//  Created by Enrico Sousa Gollner on 16/12/23.
//

import AVFoundation
import UIKit

class ChatView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpVisualElements()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpVisualElements() {
        
        
        self.configConstaints()
    }
    
    private func configConstaints() {
        NSLayoutConstraint.activate([
            
        ])
        
    }
    
}
