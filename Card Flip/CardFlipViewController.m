//
//  CardFlipViewController.m
//  Card Flip
//
//  Created by Jacob Tomaw on 3/2/14.
//  Copyright (c) 2014 TomawHaus. All rights reserved.
//

#import "CardFlipViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardFlipViewController ()

@property (nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation CardFlipViewController

- (CardMatchingGame *) game {
    if (!_game) _game = [[CardMatchingGame alloc]
                         initWithCardCount:[self.cardButtons count]
                         usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game chooseCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    for (UIButton *button in self.cardButtons) {
        NSUInteger index = [self.cardButtons indexOfObject:button];
        Card *card = [self.game cardAtIndex:index];
        [button setBackgroundImage:[self getBackgroundImageForCard:card]
                          forState:UIControlStateNormal];
        [button setTitle:[self getTitleForCard:card]
                forState:UIControlStateNormal];
    }
}

- (UIImage *) getBackgroundImageForCard:(Card *) card {
    return card.isChosen ? nil : [UIImage imageNamed:@"Card Back"];
}

- (NSString *) getTitleForCard:(Card *) card {
    return card.isChosen ? card.contents : @"";
}

@end
