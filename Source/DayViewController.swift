import UIKit
import DateTools

open class DayViewController: UIViewController, DayViewDelegate {

  lazy var dayView: DayView = DayView()

  override open func viewDidLoad() {
    super.viewDidLoad()
    self.edgesForExtendedLayout = UIRectEdge()
    view.addSubview(dayView)
    view.tintColor = UIColor.red

    dayView.dataSource = self
    dayView.reloadData()
  }

  open override func viewDidLayoutSubviews() {
    dayView.fillSuperview()
  }
}

extension DayViewController: DayViewDataSource {
  func eventDescriptorsForDate(_ date: Date) -> [EventDescriptor] {
    return generateMockEventsForDate(date)
  }

  func generateMockEventsForDate(_ date: Date) -> [EventDescriptor] {
    var date = date
    var events = [Event]()
    let step = 2

    date = date.add(TimeChunk(seconds: 0, minutes: 24, hours: 0, days: 0, weeks: 0, months: 0, years: 0))

    for i in 0...10  {
      let event = Event()

      let duration = Int(arc4random_uniform(160) + 30)
      let datePeriod = TimePeriod(beginning: date, chunk: TimeChunk(seconds: 0, minutes: duration, hours: 0, days: 0, weeks: 0, months: 0, years: 0))

      event.datePeriod = datePeriod

      var eventInfo = [String]()
      eventInfo.append("Text \(i)")
      eventInfo.append(datePeriod.beginning!.format(with: .full)!)

      event.data = eventInfo

      let addNext = Int(arc4random_uniform(160) + 30)
      date = date.add(TimeChunk(seconds: 0, minutes: addNext  , hours: 0, days: 0, weeks: 0, months: 0, years: 0))

      event.color = UIColor.orange

      events.append(event)
    }

    return events
  }

  // MARK: DayViewDelegate

  func dayViewDidSelectEventView(_ eventview: EventView) {

  }

  func dayViewDidLongPressEventView(_ eventView: EventView) {
    
  }
}
