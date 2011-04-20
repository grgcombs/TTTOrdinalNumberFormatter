# TTTOrdinalNumberFormatter
## Your *1st* choice for formatting localized ordinal numbers

Core Foundation's NSNumberFormatter is great for [Cardinal numbers](http://en.wikipedia.org/wiki/Cardinal_number) (17, 42, 69, etc.), but it doesn't have built-in support for [Ordinal numbers](http://en.wikipedia.org/wiki/Ordinal_number_(linguistics)) (1st, 2nd, 3rd, etc.)

A naïve implementation might be as simple as throwing the one's place in a switch statement and appending "-st", "-nd", etc. But what if you want to support French, which appends "-er", "-ère", and "-eme" in various contexts? How about Spanish? Japanese?

`TTTOrdinalNumberFormatter` supports English, Spanish, French, Irish, Italian, Japanese, Dutch, Portuguese, and Mandarin Chinese. For other languages, you can use the standard default, or override it with your own. For languages whose ordinal indicator depends upon the grammatical properties of the predicate, `TTTOrdinalNumberFormatter` can format according to a specified gender and/or plurality.

## Example Usage

Using `TTTOrdinalNumberFormatter` is as simple as dropping the files in your project and adding `#include "TTTOrdinalNumberFormatter.h"` at the top of classes that use it. Here's what it looks like in standard usage:

    TTTOrdinalNumberFormatter *ordinalNumberFormatter = [[TTTOrdinalNumberFormatter alloc] init]; 
    [ordinalNumberFormatter setLocale:[NSLocale currentLocale]];
    [ordinalNumberFormatter setGrammaticalGender:TTTOrdinalNumberFormatterMaleGender];
    NSNumber *number = [NSNumber numberWithInteger:2];
    NSLog(@"%@", [NSString stringWithFormat:NSLocalizedString(@"You came in %@ place!", nil), [ordinalNumberFormatter stringFromNumber:number]]);
    
Assuming you've provided localized strings for "You came in %@ place!", the output would be:

- English: "You came in 2nd place!"
- French: "Vous êtes venu à la 2eme place!"
- Spanish: "Usted llegó en 2.o lugar!"

One instance where you might want to override the ordinal indicator would be if you're localizing into Japanese, which uses [different counters](http://en.wikipedia.org/wiki/Japanese_counter_word#Full_list_of_counters), depending on the type of object (eg. minutes, flat objects, people, books, etc.) To make it an ordinal, you .

    TTTOrdinalNumberFormatter *ordinalNumberFormatter = [[TTTOrdinalNumberFormatter alloc] init]; 
    [ordinalNumberFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"] autorelease]];
    [ordinalNumberFormatter setOrdinalIndicator:@"回目"]; // add 目 to make it an ordinal
    [ordinalNumberFormatter setNumberStyle:NSNumberFormatterSpellOutStyle]; // use Japanese numberals, where supported
    NSNumber *number = [NSNumber numberWithInteger:1];
    NSLog(@"%@", [NSString stringWithFormat:@"これは、私はテキサス州を訪問%@です", number]); // # => これは、私はテキサス州を訪問一回目です

## License

TTTOrdinalNumberFormatter is licensed under the MIT License:

  Copyright (c) 2011 Mattt Thompson (http://mattt.me/)

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
