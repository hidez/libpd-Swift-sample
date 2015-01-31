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
    PdAudioStatus status = [audioController configurePlaybackWithSampleRate:sampleRate numberChannels:numChannels inputEnabled:numChannels mixingEnabled:mixingEnabled];
    switch (status) {
        case PdAudioError:
            return PdAudioControlStatusError;
            break;
        case PdAudioPropertyChanged:
            return PdAudioControlStatusPropertyChanged;
            break;
        default:
            return PdAudioControlStatusOK;
            break;
    }
}

- (PdAudioControlStatus)configureAmbientWithSampleRate:(int)sampleRate numberChannels:(int)numChannels mixingEnabled:(BOOL)mixingEnabled audioController:(PdAudioController *)audioController
{
    PdAudioStatus status = [audioController configureAmbientWithSampleRate:sampleRate numberChannels:numChannels mixingEnabled:mixingEnabled];
    switch (status) {
        case PdAudioError:
            return PdAudioControlStatusError;
            break;
        case PdAudioPropertyChanged:
            return PdAudioControlStatusPropertyChanged;
            break;
        default:
            return PdAudioControlStatusOK;
            break;
    }
    
}

@end
