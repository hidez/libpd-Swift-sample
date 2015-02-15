//
//  PdAudioController-Bridging.m
//  TuningFork
//
//  Created by Hidehisa YOKOYAMA on 2015/01/30.
//  Copyright (c) 2015年 Hidehisa YOKOYAMA. All rights reserved.
//

#import "PdAudioController-Bridging.h"

@implementation PdAudioController_Bridging

- (PdAudioControlStatus)configurePlaybackWithSampleRate:(int)sampleRate numberChannels:(int)numChannels inputEnabled:(BOOL)inputEnabled mixingEnabled:(BOOL)mixingEnabled audioController:(PdAudioController *)audioController
{
    PdAudioControlStatus status = (NSInteger)[audioController configurePlaybackWithSampleRate:sampleRate numberChannels:numChannels inputEnabled:numChannels mixingEnabled:mixingEnabled];
    return status;
}

- (PdAudioControlStatus)configureAmbientWithSampleRate:(int)sampleRate numberChannels:(int)numChannels mixingEnabled:(BOOL)mixingEnabled audioController:(PdAudioController *)audioController
{
    PdAudioControlStatus status = (NSInteger)[audioController configureAmbientWithSampleRate:sampleRate numberChannels:numChannels mixingEnabled:mixingEnabled];
    return status;
}

@end
