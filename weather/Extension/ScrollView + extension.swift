import Foundation
import UIKit

extension UIScrollView {
    func setupMaskCellForScrollView(scrollView: UIScrollView, tableView: UITableView) {
        let y: CGFloat = scrollView.contentOffset.y
        for cell in tableView.visibleCells {
            let paddingToDissapear: CGFloat = 135
            let hiddenFrameHeight = y + paddingToDissapear - cell.frame.origin.y
            if hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height {
                if let customCell = cell as? TableDayliCell {
                    customCell.maskCell(fromTop: hiddenFrameHeight)
                }
                if let customCell = cell as? TableCellDescription {
                    customCell.maskCell(fromTop: hiddenFrameHeight)
                }
                if let customCell = cell as? TableCellProperties {
                    customCell.maskCell(fromTop: hiddenFrameHeight)
                }
                if let customCell = cell as? TableCellMap {
                    customCell.maskCell(fromTop: hiddenFrameHeight)
                }
            }
        }
    }
}

extension UIScrollView {
    func setupScrollView(scrollView: UIScrollView, myConstaint: NSLayoutConstraint, topCityConstraint: NSLayoutConstraint, tempCurrentLabel: UILabel, maxMinTempLabel: UILabel, imageView: UIImageView) {
        let offsetY =  220 - (scrollView.contentOffset.y)
        let height = max(40, offsetY)
        let rect = CGRect(x: 0, y: 0, width: self.bounds.width, height: height)
        myConstaint.constant = rect.height
        if offsetY >= 190 {
            topCityConstraint.constant = 60
            UIView.animate(withDuration: 0.5) {
                tempCurrentLabel.alpha = 0.9
                maxMinTempLabel.alpha = 0.7
                imageView.alpha = 0.9
                self.layoutIfNeeded()
            }
        } else if offsetY >= 170 {
            topCityConstraint.constant = 55
            UIView.animate(withDuration: 0.5) {
                tempCurrentLabel.alpha = 0.7
                maxMinTempLabel.alpha = 0.4
                imageView.alpha = 0.7
                self.layoutIfNeeded()
            }
        } else if offsetY >= 150 {
            topCityConstraint.constant = 50
            UIView.animate(withDuration: 0.5) {
                tempCurrentLabel.alpha = 0.5
                maxMinTempLabel.alpha = 0.1
                imageView.alpha = 0.5
                self.layoutIfNeeded()
            }
        } else if offsetY >= 130 {
            topCityConstraint.constant = 40
            UIView.animate(withDuration: 0.5) {
                tempCurrentLabel.alpha = 0.3
                maxMinTempLabel.alpha = 0.0
                imageView.alpha = 0.3
                self.layoutIfNeeded()
            }
        } else if offsetY >= 110 {
            topCityConstraint.constant = 35
            UIView.animate(withDuration: 0.5) {
                tempCurrentLabel.alpha = 0.1
                imageView.alpha = 0.1
                self.layoutIfNeeded()
            }
        } else if offsetY >= 90 {
            topCityConstraint.constant = 30
            UIView.animate(withDuration: 0.5) {
                tempCurrentLabel.alpha = 0
                imageView.alpha = 0
                self.layoutIfNeeded()
            }
        } else if offsetY <= 190 {
            topCityConstraint.constant = 30
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
        }
    }
}
