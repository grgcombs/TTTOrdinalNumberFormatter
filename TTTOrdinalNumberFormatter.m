// TTTOrdinalNumberFormatter.m
//
// Copyright (c) 2011 Mattt Thompson (http://mattt.me)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "TTTOrdinalNumberFormatter.h"

static NSString * const kTTTOrdinalNumberFormatterDefaultOrdinalIndicator = @".";

@interface TTTOrdinalNumberFormatter ()
- (NSString *)localizedOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)deOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)enOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)esOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)frOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)gaOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)itOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)jaOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)nlOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)ptOrdinalIndicatorStringFromNumber:(NSNumber *)number;
- (NSString *)zhHansOrdinalIndicatorStringFromNumber:(NSNumber *)number;
@end

@implementation TTTOrdinalNumberFormatter
@synthesize ordinalIndicator;
@synthesize grammaticalGender;
@synthesize grammaticalNumber;

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.numberStyle = NSNumberFormatterNoStyle;
    [self setAllowsFloats:NO];
    [self setGeneratesDecimalNumbers:NO];
    self.roundingMode = NSNumberFormatterRoundFloor;
    self.minimum = @0;
    [self setLenient:YES];
    
    return self;
}


- (NSString *)stringFromNumber:(NSNumber *)number {
    NSString *indicator = self.ordinalIndicator;
    if (!indicator) {
        indicator = [self localizedOrdinalIndicatorStringFromNumber:number];
    }
    
    [self setPositivePrefix:nil];
    [self setPositiveSuffix:nil];
    
    NSString *languageCode = [self.locale objectForKey:NSLocaleLanguageCode];
    if ([languageCode isEqualToString:@"zh"]) {
        self.positivePrefix = indicator;
    } else {
        self.positiveSuffix = indicator;
    }
    
    return [super stringFromNumber:number];
}

#pragma mark -

- (NSString *)localizedOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    NSString *languageCode = [self.locale objectForKey:NSLocaleLanguageCode];
    if ([languageCode isEqualToString:@"en"]) {
        return [self enOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"fr"]) {
        return [self frOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"nl"]) {
        return [self nlOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"it"]) {
        return [self itOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"pt"]) {
        return [self ptOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"es"]) {
        return [self esOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"ga"]) {
        return [self gaOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"ja"]) {
        return [self jaOrdinalIndicatorStringFromNumber:number];
    } else if ([languageCode isEqualToString:@"zh"]) {
        return [self zhHansOrdinalIndicatorStringFromNumber:number];
    } else {
        return kTTTOrdinalNumberFormatterDefaultOrdinalIndicator;
    }
}

- (NSString *)deOrdinalIndicatorStringFromNumber:(NSNumber *)number {
	return @".";
}

- (NSString *)enOrdinalIndicatorStringFromNumber:(NSNumber *)number {
	NSInteger value = number.integerValue;
	NSString *suffix = @"";
	if (value > 0) {
		switch(value % 10) {
			case 1: suffix = @"st"; break;
			case 2: suffix = @"nd"; break;
			case 3: suffix = @"rd"; break;
			default: suffix = @"th"; break;
		}
		if (value % 100 >= 11 && value % 100 <= 13)  {
			suffix = @"th"; // Handle 11-13
    }
    }
	return suffix;
}

- (NSString *)esOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    switch (self.grammaticalGender) {
        case TTTOrdinalNumberFormatterMaleGender:
            return @".o";
        case TTTOrdinalNumberFormatterFemaleGender:
            return @".a";
        default:
            return kTTTOrdinalNumberFormatterDefaultOrdinalIndicator;
    }
}

- (NSString *)frOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    NSUInteger ulp = number.integerValue % 10;
    switch (ulp) {
        case 1:
            switch (self.grammaticalGender) {
                case TTTOrdinalNumberFormatterMaleGender:
                    return @"er";
                case TTTOrdinalNumberFormatterFemaleGender:
                    return @"ère";
                default:
                    return @"er";
            }
        default:
            return @"eme";
    }
}

- (NSString *)gaOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    return @"ú";
}

- (NSString *)itOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    switch (self.grammaticalGender) {
        case TTTOrdinalNumberFormatterMaleGender:
            return @".o";
        case TTTOrdinalNumberFormatterFemaleGender:
            return @".a";
        default:
            return kTTTOrdinalNumberFormatterDefaultOrdinalIndicator;
    }
}

- (NSString *)jaOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    return @"番";
}

- (NSString *)nlOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    return @"e";
}

- (NSString *)ptOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    switch (self.grammaticalGender) {
        case TTTOrdinalNumberFormatterMaleGender:
            return @".o";
        case TTTOrdinalNumberFormatterFemaleGender:
            return @".a";
        default:
            return kTTTOrdinalNumberFormatterDefaultOrdinalIndicator;
    }
}

- (NSString *)zhHansOrdinalIndicatorStringFromNumber:(NSNumber *)number {
    return @"第";
}

@end
