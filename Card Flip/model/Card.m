//
//  Card.m
//  Card Flip
//
//  Created by Jacob Tomaw on 3/3/14.
//  Copyright (c) 2014 TomawHaus. All rights reserved.
//

#import "Card.h"

@implementation Card

- (NSInteger) match:(NSArray *)otherCards {
    for (Card *otherCard in otherCards) {
        if (self.contents == otherCard.contents) {
            return 1;
        }
    }
    
    return 0;
}

@end
