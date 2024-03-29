//
//  structForPixels.swift
//  mob dev
//
//  Created by spoonty on 5/5/21.
//  Copyright © 2021 Пользователь. All rights reserved.
//

import Foundation

public struct RGBAPixel {
    public init(rawVal : UInt32){
        raw = rawVal
    }
    
    public var raw: UInt32
    
    public var red: UInt8 {
        get { return UInt8(raw & 0xFF) }
        set { raw = UInt32(newValue) | (raw & 0xFFFFFF00) }
    }
    
    public var green: UInt8 {
        get { return UInt8((raw & 0xFF00) >> 8 )}
        set { raw = (UInt32(newValue) << 8) | (raw & 0xFFFF00FF) }
    }
    public var blue: UInt8 {
        get { return UInt8((raw & 0xFF0000) >> 16) }
        set { raw = (UInt32(newValue) << 16) | (raw & 0xFF00FFFF) }
    }
    public var alpha: UInt8 {
        get { return UInt8(( raw & 0xFF000000) >> 24) }
        set { raw = (UInt32(newValue) << 24) | (raw & 0x00FFFFFF) }
    }
}
