//
//  RandomBytes.swift
//  Sodium
//
//  Created by Frank Denis on 12/27/14.
//  Copyright (c) 2014 Frank Denis. All rights reserved.
//

import Foundation

public class RandomBytes {
    /**
     Returns a `Data object of length `length` containing an unpredictable sequence of bytes.
 
     - Parameter length: The number of bytes to generate.
 
     - Returns: The generated data.
     */
    public func buf(length: Int) -> Data? {
        if length < 0 {
            return nil
        }
        var output = Data(count: length)
        output.withUnsafeMutableBytes { outputPtr in
            randombytes_buf(outputPtr, output.count)
        }
        return output
    }

    /**
     - Returns: An unpredictable value between 0 and 0xffffffff (included).
     */
    public func random() -> UInt32 {
        return randombytes_random()
    }

    /**
     Returns an unpredictable value between 0 and `upper_bound` (excluded). Unlike randombytes_random() % upper_bound, it does its best to guarantee a uniform distribution of the possible output values even when upper_bound is not a power of 2.
     
     - Parameter upperBound: The upper bound (excluded) of the returned value.
     
     - Returns: The unpredictable value.
     */
    public func uniform(upperBound: UInt32) -> UInt32 {
        return randombytes_uniform(upperBound)
    }
}
