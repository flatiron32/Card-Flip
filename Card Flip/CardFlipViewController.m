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
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardMatch;
@property (nonatomic) NSInteger score;
@property (strong, nonatomic) NSMutableArray *selection;
@end

@implementation CardFlipViewController

- (CardMatchingGame *) game {
    if (!_game) {
        _game = [[CardMatchingGame alloc]
                 initWithCardCount:[self.cardButtons count]
                 usingDeck:[[PlayingCardDeck alloc] init]];
        _game.matchCount = self.cardMatch.selectedSegmentIndex + 2;
    }
    
    return _game;
}

- (NSMutableArray *) selection {
    if (!_selection) {
        _selection = [[NSMutableArray alloc] init];
    }
    
    return _selection;
}

- (void)drawUIForGame:(CardMatchingGame *) game withCard:(UIButton *) flippedCard {
    NSMutableString *activityString = [[NSMutableString alloc] init];

    if (flippedCard) {
        Card *theCard = [self cardForButton:flippedCard fromGame:self.game];

        if (theCard.isChosen) {
            NSLog(@"Chosen");
            [self.selection addObject:theCard];
            if (theCard.isMatched) {
                NSLog(@"Match");
                NSInteger scoreDiff = (game.score - self.score);
                
                [activityString appendString:@"Matched"];
                for (Card *matchCard in self.selection) {
                    [activityString appendFormat:@" %@", matchCard.contents];
                }
                [activityString appendFormat:@" for %ld points!", scoreDiff];
                [self.selection removeAllObjects];
            } else { //Not a match (yet?)
                NSLog(@"Not Match");
                if (self.selection.count > 1) { //Was matching
                    NSLog(@"Was Match");
                    Card *selectedCard = self.selection.firstObject;
                    if (selectedCard.isChosen) { //Open Match
                        NSLog(@"Open Match");
                        for (Card *matchCard in self.selection) {
                            [activityString appendFormat:@" %@", matchCard.contents];
                        }
                    } else { // Bad Match
                        NSLog(@"Bad Match");
                        NSInteger scoreDiff = (game.score - self.score);
                        
                        for (Card *selectedCard in self.selection) {
                            [activityString appendFormat:@" %@", selectedCard.contents];
                        }
                        [activityString appendString:@" do not match!\n"];
                        [activityString appendFormat:@"%ld point penalty!", ABS(scoreDiff)];
                        [self.selection removeAllObjects];
                        [self.selection addObject:theCard];
                    }
                } else { //Only one card selected
                    for (Card *selectedCard in self.selection) {
                        [activityString appendFormat:@" %@", selectedCard.contents];
                    }
                }
            }
        } else { //Flip down
            [self.selection removeObject:theCard];
            for (Card *selectedCard in self.selection) {
                [activityString appendFormat:@" %@", selectedCard.contents];
            }
        }
    }
    
    self.activityLabel.text = activityString;
    self.score = game.score;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long) game.score];

    for (UIButton *button in self.cardButtons) {
        Card *card = [self cardForButton:button fromGame:game];
        [button setBackgroundImage:[self getBackgroundImageForCard:card]
                          forState:UIControlStateNormal];
        [button setTitle:[self getTitleForCard:card]
                forState:UIControlStateNormal];
    }
}

- (Card *)cardForButton:(UIButton *) button fromGame:(CardMatchingGame *) game {
    return [game cardAtIndex:[self.cardButtons indexOfObject:button]];
}

- (UIImage *) getBackgroundImageForCard:(Card *) card {
    return card.isChosen ? nil : [UIImage imageNamed:@"Card Back"];
}

- (NSString *) getTitleForCard:(Card *) card {
    return card.isChosen ? card.contents : @"";
}

- (IBAction)flipCard:(UIButton *)sender {
    self.cardMatch.enabled = NO;
    [self.game chooseCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    [self drawUIForGame:self.game withCard:sender];
}

- (IBAction)reDeal:(id)sender {
    self.game = nil;
    [self drawUIForGame:nil withCard:nil];
    self.cardMatch.enabled = YES;
}
@end
