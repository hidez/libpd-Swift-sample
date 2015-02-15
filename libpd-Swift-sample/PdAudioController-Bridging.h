//
//  PdAudioController-Bridging.h
//  TuningFork
//
//  Created by Hidehisa YOKOYAMA on 2015/01/30.
//  Copyright (c) 2015年 Hidehisa YOKOYAMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PdAudioController.h" //libpd

typedef NS_ENUM(NSInteger, PdAudioControlStatus) {
	PdAudioControlStatusOK = PdAudioOK, //success
	PdAudioControlStatusError = PdAudioError, //unrecoverable error
	PdAudioControlStatusPropertyChanged = PdAudioPropertyChanged //some properties have changed to run correctly (not fatal)
};

@interface PdAudioController_Bridging : NSObject

//Maybe Swift accept only NS_ENUM.
//This methods are driver for changing enum to NS_ENUM.
- (PdAudioControlStatus)configurePlaybackWithSampleRate:(int)sampleRate numberChannels:(int)numChannels inputEnabled:(BOOL)inputEnabled mixingEnabled:(BOOL)mixingEnabled audioController:(PdAudioController *)audioController;
- (PdAudioControlStatus)configureAmbientWithSampleRate:(int)sampleRate numberChannels:(int)numChannels mixingEnabled:(BOOL)mixingEnabled audioController:(PdAudioController *)audioController;

@end
