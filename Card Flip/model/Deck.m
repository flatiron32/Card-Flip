//
//  Deck.m
//  Card Flip
//
//  Created by Jacob Tomaw on 3/3/14.
//  Copyright (c) 2014 TomawHaus. All rights reserved.
//

#import "Deck.h"

@interface Deck ()

@property (strong, nonatomic) NSMutableArray *cards;

@end


@implementation Deck

- (NSMutableArray *) cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void) addCard:(Card *)card {
    [self.cards addObject:card];
}

- (Card *) drawRandomCard {
    unsigned index = arc4random() % [self.cards count];
    Card *randomCard = self.cards[index];
    [self.cards removeObjectAtIndex:index];
    return randomCard;
}

@end
