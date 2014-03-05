//
//  CardMatchingGame.m
//  Card Flip
//
//  Created by Jacob Tomaw on 3/4/14.
//  Copyright (c) 2014 TomawHaus. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        while (self.cards.count < count) {
            [self.cards addObject:[deck drawRandomCard]];
            NSLog(@"Added card number %lu to game", (unsigned long)self.cards.count);
        }
    }
    
    return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    for (Card *card in self.cards) {
        if (!card.isMatched) {
            card.chosen = NO;
        }
    }

    Card *card = self.cards[index];
    if (card.chosen)
    card.chosen = YES;
}

-(Card *)cardAtIndex:(NSUInteger)index {
    return self.cards[index];
}

@end
