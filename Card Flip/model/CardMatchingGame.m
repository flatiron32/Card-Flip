//
//  CardMatchingGame.m
//  Card Flip
//
//  Created by Jacob Tomaw on 3/4/14.
//  Copyright (c) 2014 TomawHaus. All rights reserved.
//

#import "CardMatchingGame.h"

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (readwrite) NSInteger score;
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
    Card *card = self.cards[index];

    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    NSInteger matchScore = [card match:@[otherCard]];
                    
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

-(Card *)cardAtIndex:(NSUInteger)index {
    return self.cards[index];
}

@end
