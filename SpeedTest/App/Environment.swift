//
//  Environmetn.swift
//  SpeedTest
//
//  Created by Evgenii Mikhailov on 24.04.2024.
//

import Foundation
import SwiftUI

struct SpeedTestServiceKey: EnvironmentKey {
    static let defaultValue: SpeedTestService? = nil
}

extension EnvironmentValues {
    var speedTestService: SpeedTestService? {
        get { self[SpeedTestServiceKey.self] }
        set { self[SpeedTestServiceKey.self] = newValue }
    }
}
