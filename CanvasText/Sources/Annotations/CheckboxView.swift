#if os(OSX)
	import AppKit
#else
	import UIKit
#endif

import CanvasNative
import X

final class CheckboxView: UIButton, Annotation {

    // MARK: - Properties

	var block: Annotatable {
		didSet {
			guard let old = oldValue as? ChecklistItem, let new = block as? ChecklistItem else {
            return
        }

			if old.state != new.state {
				setNeedsDisplay()
			}
		}
	}

	var theme: Theme {
		didSet {
			backgroundColor = theme.backgroundColor
			tintColor = theme.tintColor
			setNeedsDisplay()
		}
	}

	var horizontalSizeClass: UserInterfaceSizeClass = .unspecified

    // MARK: - Initializers

	init?(block: Annotatable, theme: Theme) {
		guard let checklistItem = block as? ChecklistItem else {
            return nil
        }
		self.block = checklistItem
		self.theme = theme

		super.init(frame: .zero)

		backgroundColor = theme.backgroundColor
		contentMode = .redraw
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    // MARK: - UIView

	override func draw(_ rect: CGRect) {
		guard let checklistItem = block as? ChecklistItem else {
            return
        }

		let lineWidth: CGFloat = 2
		let rect = checkboxRect(for: bounds).insetBy(dx: lineWidth / 2, dy: lineWidth / 2)

		if checklistItem.state == .checked {
			tintColor.setFill()
			UIBezierPath(roundedRect: rect, cornerRadius: rect.height / 2).fill()

			if let checkmark = UIImage(named: "CheckmarkSmall", in: resourceBundle) {
				theme.backgroundColor.setFill()
				checkmark.draw(at: CGPoint(x: rect.origin.x + (rect.width - checkmark.size.width) / 2,
										   y: rect.origin.y + (rect.height - checkmark.size.height) / 2))
			}
			return
		}

		theme.uncheckedCheckboxColor.setStroke()
		let path = UIBezierPath(roundedRect: rect.insetBy(dx: 1, dy: 1), cornerRadius: rect.height / 2)
		path.lineWidth = lineWidth
		path.stroke()
	}

	override func tintColorDidChange() {
		super.tintColorDidChange()
		setNeedsDisplay()
	}

    // MARK: - Private

	private func checkboxRect(for bounds: CGRect) -> CGRect {
		let size = bounds.height

		return CGRect(
			x: bounds.size.width - size - 4,
			y: floor((bounds.size.height - size) / 2) - 1,
			width: size,
			height: size
		)
	}
}
