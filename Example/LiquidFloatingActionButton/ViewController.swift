//
//  ViewController.swift
//  LiquidFloatingActionButton
//
//  Created by Takuma Yoshida on 08/25/2015.
//  Copyright (c) 2015 Takuma Yoshida. All rights reserved.
//

import UIKit
import SnapKit
import LiquidFloatingActionButton

public class CustomCell : LiquidFloatingCell {
    var name: String = "sample"
    
    init(icon: UIImage, name: String) {
        self.name = name
        super.init(icon: icon)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func setupView(view: UIView) {
        super.setupView(view)
        let label = UILabel()
        label.text = name
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "Helvetica-Neue", size: 12)
        addSubview(label)
        label.snp_makeConstraints { make in
            make.centerY.equalTo(self).offset(30)
            make.width.equalTo(75)
            make.centerX.height.equalTo(self)
        }
    }
}

class ViewController: UIViewController, LiquidFloatingActionButtonDataSource, LiquidFloatingActionButtonDelegate {
    
    var cells: [LiquidFloatingCell] = []
    var floatingActionButton: LiquidFloatingActionButton!

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor(red: 55 / 255.0, green: 55 / 255.0, blue: 55 / 255.0, alpha: 1.0)
        // Do any additional setup after loading the view, typically from a nib.
        let createButton: (CGRect, LiquidFloatingActionButtonAnimateStyle) -> LiquidFloatingActionButton = { (frame, style) in
            let floatingActionButton = LiquidFloatingActionButton(frame: frame)
            floatingActionButton.animateStyle = style
            floatingActionButton.dataSource = self
            floatingActionButton.delegate = self
            return floatingActionButton
        }
        
        let cellFactory: (String) -> LiquidFloatingCell = { (iconName) in
            let cell = LiquidFloatingCell(icon: UIImage(named: iconName)!)
            return cell
        }
        let customCellFactory: (String) -> LiquidFloatingCell = { (iconName) in
            let cell = CustomCell(icon: UIImage(named: iconName)!, name: iconName)
            return cell
        }
        cells.append(cellFactory("ic_cloud"))
        cells.append(customCellFactory("ic_system"))
        cells.append(cellFactory("ic_place"))
        
        let floatingFrame = CGRect(x: self.view.frame.width - 56 - 16, y: self.view.frame.height - 56 - 16, width: 56, height: 56)
        let bottomRightButton = createButton(floatingFrame, .Up)
        
        let floatingFrame2 = CGRect(x: 16, y: 16, width: 56, height: 56)
        let topLeftButton = createButton(floatingFrame2, .Down)
		
		let floatingFrameBottomMiddle = CGRect(
			x: (self.view.frame.width - 56 - 16) / 2,
			y: self.view.frame.height - 56 - 16,
			width: 56,
			height: 56
		)
		
		let bottomMiddleButton = createButton(floatingFrameBottomMiddle, .FanUp)
		
		self.view.addSubview(bottomRightButton)
		self.view.addSubview(topLeftButton)
		self.view.addSubview(bottomMiddleButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfCells(liquidFloatingActionButton: LiquidFloatingActionButton) -> Int {
        return cells.count
    }
    
    func cellForIndex(index: Int) -> LiquidFloatingCell {
        return cells[index]
    }
    
    func liquidFloatingActionButton(liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int) {
        print("did Tapped! \(index)")
        liquidFloatingActionButton.close()
    }

}
