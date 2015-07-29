//
//  RecruitmentKindCell.swift
//  Workout
//
//  Created by 赵雨 on 7/29/15.
//  Copyright (c) 2015 Hippocn. All rights reserved.
//

import UIKit

enum RecruitmentsKind: Printable{
    case Sponsorship
    case Enrollment
    case Collection
    
    var description : String {
        switch self {
            // Use Internationalization, as appropriate.
        case .Sponsorship: return "Sponsorship";
        case .Enrollment: return "Enrollment";
        case .Collection: return "Collection";
        }
    }
}

protocol RecruitmentsKindCellDelegate: class {
    func recruitmentsKindCell(cell: RecruitmentsKindCell, didSelectRecruitmentsKind kind: RecruitmentsKind)
}

class RecruitmentsKindCell: UITableViewCell {
    
    
    
    var recruitmentsKind: RecruitmentsKind = .Sponsorship
    var delegate: RecruitmentsKindCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        addColumns(3)
        addViews(3)
        // Initialization code
    }

    
    func addColumns(number: Int) {
        let screenRect = UIScreen.mainScreen().bounds
        let span = screenRect.width / CGFloat(number)
        print("width: \(screenRect.width), number: \(number), span: \(span)")
        for n in 0...(number - 2) {
            let rect = CGRectMake(span * CGFloat(n + 1), 4, 1, self.bounds.height - 8)
            let column = UIView(frame: rect)
            column.backgroundColor = UIColor.lightGrayColor()
            self.addSubview(column)
        }
    }
    
    func addViews(number: Int) {
        for n in 0...(number - 1) {
            let screenRect = UIScreen.mainScreen().bounds
            let span = screenRect.width / CGFloat(number)
            let rect = CGRectMake(span * CGFloat(n) + (span - 36) / 2, 4, 36, 36)
            let view = UIView(frame: rect)
            view.backgroundColor = UIColor.blueColor()
            view.userInteractionEnabled = true
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showRecruitments:")
            view.addGestureRecognizer(tapGestureRecognizer)
            
            view.tag = 100 + n
            
            self.addSubview(view)
        }
    }
    
    func showRecruitments(recoginzer: UITapGestureRecognizer) {
        switch recoginzer.view!.tag {
        case 100:
            recruitmentsKind = .Sponsorship
        case 101:
            recruitmentsKind = .Enrollment
        case 102:
            recruitmentsKind = .Collection
        default:break
        }
        configureSelectionWithTag(recoginzer.view!.tag)
        if let delegate = delegate {
            delegate.recruitmentsKindCell(self, didSelectRecruitmentsKind: recruitmentsKind)
        }
    }
    
    func configureSelectionWithTag(tag: Int) {
        if tag == 100 {
            var deselectView = self.viewWithTag(101)
            deselectView!.backgroundColor = UIColor.blueColor()
            deselectView = self.viewWithTag(102)
            deselectView!.backgroundColor = UIColor.blueColor()
        } else if tag == 101 {
            var deselectView = self.viewWithTag(100)
            deselectView!.backgroundColor = UIColor.blueColor()
            deselectView = self.viewWithTag(102)
            deselectView!.backgroundColor = UIColor.blueColor()
        } else {
            var deselectView = self.viewWithTag(101)
            deselectView!.backgroundColor = UIColor.blueColor()
            deselectView = self.viewWithTag(100)
            deselectView!.backgroundColor = UIColor.blueColor()
        }
        self.viewWithTag(tag)?.backgroundColor = UIColor.redColor()
    }

}
