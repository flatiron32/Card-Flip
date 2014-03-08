//
//  PlayingCard.m
//  Card Flip
//
//  Created by Jacob Tomaw on 3/3/14.
//  Copyright (c) 2014 TomawHaus. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

+ (NSArray *) validSuits {
    return @[@"♠︎", @"♣︎", @"♥︎", @"♦︎"];
}

+ (NSUInteger) maxRank {
    return 13;
}

+ (NSArray *) rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

- (NSString *) contents {
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

- (NSInteger) match:(NSArray *)otherCards {
    int score = 0;
    
    for (PlayingCard *otherCard in otherCards) {
        if (otherCard.rank == self.rank) {
            score += 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score += 1;
        }
    }
    
    return score;
}

@end
