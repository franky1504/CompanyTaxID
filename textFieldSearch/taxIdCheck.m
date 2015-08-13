//
//  taxIdCheck.m
//  textFieldSearch
//
//  Created by Franky Wu on 2015/8/12.
//  Copyright (c) 2015年 fet. All rights reserved.
//

#import "taxIdCheck.h"

@implementation taxIdCheck
//    統一編號
//A B C D E F G H
//x x x x x x x x
//1 2 1 2 1 2 4 1
//各別乘上特定倍數, 若乘出來的值為二位數則將十位數和個位數相加
//最後將所有數值加總, 被 10 整除就為正確
//if G=7, 加上 1 被 10 整除也為正確

-(int) taxIdCheck:(int)idNum{
    int temp;
    h = idNum % 10;
    temp = idNum / 10;
    g = temp % 10;
    temp = temp / 10;
    f = temp % 10;
    temp = temp / 10;
    e = temp % 10;
    temp = temp / 10;
    d = temp % 10;
    temp = temp / 10;
    c = temp % 10;
    temp = temp / 10;
    b = temp % 10;
    temp = temp / 10;
    a = temp % 10;
    
    int sum =
    [self add:a*1] +
    [self add:b*2] +
    [self add:c*1] +
    [self add:d*2] +
    [self add:e*1] +
    [self add:f*2] +
    [self add:g*4] +
    [self add:h*1];
    
    
    if (sum%10==0)
    {
        return 1;
    }
    else if (g == 7)
    {
        if ((sum+1)%10==0) {
            return 1;
        }else
            return 0;
    }
    else
    {
        return 0;
    }
}

-(int) add:(int)num {
    int units;
    int tens;
    int total;
    
    //2位數
    if (num/10 > 0) {
        units = num % 10;
        tens  = num / 10;
        total = units + tens;
        
        if (total > 9) {
            [self add:total];
        }
        
        return units+tens;
    }
    //1位數
    else {
        return num;
    }
    
}

@end
