import UIKit
import CalendarSwift
import TimeSwift
import PlaygroundSupport

let date = Date()
var calendar = Calendar(identifier: .gregorian)
let locale = Locale(identifier: "es_ES")
calendar.locale = locale

var month = Month(date: Date())
month = month.year.months.first!
month.firstDayOfTheMonthDay.weekday
month.whiteDaysAfterFirstDayOfTheMonth

PlaygroundPage.current.needsIndefiniteExecution = true
