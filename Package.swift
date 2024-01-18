// swift-tools-version: 5.4

import PackageDescription

let package = Package(
    name: "PDTSimpleCalendar",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "PDTSimpleCalendar",
            targets: ["PDTSimpleCalendar"]
        ),
    ],
    targets: [
        .target(
            name: "PDTSimpleCalendar",
            path: "PDTSimpleCalendar",
            exclude: ["Info.plist", "PDTSimpleCalendar.h"],
            sources: [
                "PDTSimpleCalendarViewCell.m",
                "PDTSimpleCalendarViewController.m",
                "PDTSimpleCalendarViewFlowLayout.m",
                "PDTSimpleCalendarViewHeader.m",
                "PDTSimpleCalendarViewWeekdayHeader.m"
            ],
            publicHeadersPath: "include"
        ),
    ]
)
