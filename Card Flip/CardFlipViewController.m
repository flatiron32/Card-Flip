//
//  CardFlipViewController.m
//  Card Flip
//
//  Created by Jacob Tomaw on 3/2/14.
//  Copyright (c) 2014 TomawHaus. All rights reserved.
//

#import "CardFlipViewController.h"
#import "PlayingCardDeck.h"

@interface CardFlipViewController ()

    @property (weak, nonatomic) IBOutlet UILabel *flipCountLabel;
    @property (nonatomic) int count;
    @property (nonatomic) Deck *deck;

@end

@implementation CardFlipViewController

- (Deck *) deck {
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (void)setCount:(int)count {
    _count = count;
    self.flipCountLabel.text = [NSString stringWithFormat:@"%d Flips", self.count];
}

- (IBAction)flipCard:(UIButton *)sender {
    if ([sender.currentTitle length] == 0) {
        [sender setBackgroundImage:nil
                          forState:UIControlStateNormal];
        [sender setTitle:[self.deck drawRandomCard].contents
                forState:UIControlStateNormal];
    } else {
        UIImage *background = [UIImage imageNamed:@"Card Back.png"];
        [sender setBackgroundImage:background forState:UIControlStateNormal];
        [sender setTitle:nil forState:UIControlStateNormal];
    }
    
    self.count++;
    
    NSLog(@"Card Flipped");
}

@end
