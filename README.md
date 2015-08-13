# 統一編號格式驗證

-(int) taxIdCheck:(NSString *)idStr;

1.傳入要判斷的統一編號字串<br />
2.若為長度不合(8位數)，則回傳 0<br />
3.若為格式不對，則回傳 0<br />
4.完全正確，回傳 1

統一編號(ABCDEFGH)<br />
A B C D E F G H<br />
x x x x x x x x<br />
1 2 1 2 1 2 4 1

1.各別乘上特定倍數,若乘出來的值為二位數則將十位數和個位數相加<br />
2.最後將所有數值加總,被 10 整除就為正確<br />
3.if G=7, 加上 1 被 10 整除也為正確

1 2 3 4 5 6 7 8<br />
x x x x x x x x<br />
1 2 1 2 1 2 4 1<br />
---------------- 相乘<br />
1 4 3 8 5 1 2 8<br />
          2 8<br />
---------------- 相加<br />
          3 1<br />
            0<br />
---------------- 還是有2位數，繼續相加<br />
1 4 3 8 5 3 1 8

1+4+3+8+5+3+1+8=33

33%10!=0 格式錯誤