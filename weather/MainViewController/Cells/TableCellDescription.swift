import UIKit

final class TableCellDescription: UITableViewCell {
// MARK: - Variable
    static let TableCellDescriptionIdentifier = "TableCellDescription"
    var current: Current?
    var dayliTemp: Temp?
    var labelDescription: UILabel?
    
// MARK: - IBOutlet
    @IBOutlet var label: UILabel!
    
//MARK: - Life cycle
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        addSubview(
            SeparatorManager.shared.setSeparatorLineFor(
                style: 1,
                width: UIApplication.shared.windows[0].frame.width
            )
        )
        addSubview(
            SeparatorManager.shared.setSeparatorLineFor(
                style: 4,
                width: UIApplication.shared.windows[0].frame.width
            )
        )
    }
    
    func configureCell() {
        backgroundColor = .clear
        label?.textColor = .black
        if labelDescription?.text == "overcast clouds" {
            label.text = "Сегодня: Сейчас overcast clouds. Температура воздуха \(Int(current?.temp ?? Double()))˚, ожидаемая максимальная температура воздуха сегодня \(Int(dayliTemp?.max ?? Double()))˚."
        } else if labelDescription?.text == "scattered clouds" {
            label.text = "Сегодня: Сейчас scattered clouds. Максимальная температура воздуха \(Int(dayliTemp?.max ?? Double()))˚. Сегодня ночью облачно, минимальная температура воздуха \(Int(dayliTemp?.min ?? Double()))˚."
        } else if labelDescription?.text == "clear sky" {
            label.text = "Сегодня: Сейчас clear sky. Температура воздуха \(Int(current?.temp ?? Double()))˚, ожидаемая максимальная температура воздуха сегодня \(Int(dayliTemp?.max ?? Double()))˚."
        } else if labelDescription?.text == "broken clouds" {
            label.text = "Ceгодня: Ceйчас broken clouds. Максимальная температура воздуха \(Int(dayliTemp?.max ?? Double()))˚. Сегодня ночью снег, минимальная температура воздуха \(Int(dayliTemp?.min ?? Double()))˚"
        } else if labelDescription?.text == "light snow" {
            label.text = "Сегодня: Сейчас snow. Температура воздуха \(Int(current?.temp ?? Double()))˚, ожидаемая максимальная температура воздуха сегодня \(Int(dayliTemp?.max ?? Double()))˚."
        } else if labelDescription?.text == "snow" {
            label.text = "Сегодня: снег, плохая видимость."
        }
    }
}
