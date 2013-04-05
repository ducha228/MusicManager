//
//  ViewController.m
//  MusicManager
//
//  Created by DucHa on 4/2/13.
//  Copyright (c) 2013 DucHa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSMutableArray *_mutArray;
    NSMutableArray *mArrayResult;
    IBOutlet UIPickerView *pickerView;
}

@property (weak, nonatomic) IBOutlet UITextField *txt_search;
@property (weak, nonatomic) IBOutlet UISwitch *chooser;
@property (weak, nonatomic) IBOutlet UIButton *btn_search;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _mutArray = [NSMutableArray new];
    _song = [[Song alloc] init:@"My love" andSinger:@"Westlife" andYear:1999 andGenre:pop andUrl:@"My love.jpg"];
    [_mutArray addObject:_song];
    _song = [[Song alloc] init:@"Happy New Year" andSinger:@"Abba" andYear:1980 andGenre:pop andUrl:@""];
    [_mutArray addObject:_song];
    _song = [[Song alloc] init:@"Tim lai" andSinger:@"Microwave" andYear:2004 andGenre:rock andUrl:@""];
    [_mutArray addObject:_song];
    _song = [[Song alloc] init:@"Love story" andSinger:@"Taylor Swift" andYear:2006 andGenre:country andUrl:@""];
    [_mutArray addObject:_song];
    _song = [[Song alloc] init:@"Black or white" andSinger:@"Michael Jackson" andYear:1982 andGenre:pop andUrl:@""];
    [_mutArray addObject:_song];
    //_pickerView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableArray *) searchSong: (NSString *) name{
    NSMutableArray *mArray = [NSMutableArray new];
    for(Song *song in _mutArray){
        if([song.name rangeOfString:name].location !=NSNotFound ||
           [song.singer rangeOfString:name].location !=NSNotFound) {
            [mArray addObject:song];
        }
    }
    return mArray;
}
- (NSMutableArray *) searchGenre: (NSString *) genre{
    NSMutableArray *mArray = [NSMutableArray new];
    GenreEnum key;
    if([genre isEqualToString:@"pop"]){
        key = pop;
    }else if([genre isEqualToString:@"rock"]) {
        key = rock;
    }else if([genre isEqualToString:@"country"]){
        key = country;
    }else if([genre isEqualToString:@"jazz"]){
        key = jazz;
    }else {
        genre = NO;
    }
    for(Song *song in _mutArray){
        if(key == song.genre){
            [mArray addObject:song];
        }
    }
    return mArray;
}

- (IBAction)searchClicked:(id)sender {
    mArrayResult = [NSMutableArray new];
    NSString *keyword = self.txt_search.text;
        if([_chooser isOn]){
        mArrayResult = [self searchSong:keyword];
    }else {
        mArrayResult = [self searchGenre:keyword];
    }
    NSLog(@"%d",mArrayResult.count);
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)thePickerView{
    //if([pickerView isEqual:_pickerView])
        return 1;
    //return 0;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)componenterView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component{
    return [mArrayResult count];
}

-(NSString *) pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    //Song *song = [mArrayResult objectAtIndex:row];
    //return song.description;
    return @"My love";
}

-(void) pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    Song *searchedSong = [mArrayResult objectAtIndex:row];
    UIImage *image = [UIImage imageNamed:searchedSong.imageUrl];
    [_coverImage setImage:image];
}
@end
