//
//  AsteriodBehavior.swift
//  Asteroids
//
//  Created by Mac_Work on 13.10.17.
//  Copyright © 2017 Mac_Work. All rights reserved.
//

import UIKit

class AsteriodBehavior: UIDynamicBehavior {
    
    private var asteroids = [AsteroidView]()
    
    func addAsteroid(_ asteroid: AsteroidView) {
        asteroids.append(asteroid)
    }
    
    func removeAsteroid(_ asteroid: AsteroidView) {
        if let index = asteroids.index(of: asteroid) {
            asteroids.remove(at: index)
        }
    }
    
    
    
    
    
    func pushAllAsteroids(by magnitude: Range<CGFloat> = 0..<0.5) {
        for asteroid in asteroids {
            let pusher = UIPushBehavior(items: [asteroid], mode: .instantaneous)
            pusher.magnitude = CGFloat.random(in: magnitude)
            pusher.angle = CGFloat.random(in: 0..<CGFloat.pi*2)
            addChildBehavior(pusher)
        }
    }

}
