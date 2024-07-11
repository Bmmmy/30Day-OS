; hello-os 
; TAB=4

		ORG		0x7c00			; このプログラムがどこに読み込まれるのか ; 告訴nask在開始執行時把這些機器語言指令裝到?存中的?個地址。 
		;從Ox7c00開始  $:輸出文件第幾個字節 -->要讀入的?存地址

; 以下は標準的なFAT12フォーマットフロッピーディスクのための記述 以下為用於標準FAT12的磁?片

		JMP		entry	;標籤的聲明 指定JMP的跳轉目的等 == JMP Ox7c50 entry=Ox7c50
		DB		0x90
		DB		"HELLOIPL"		; ブートセクタの名前を自由に書いてよい（8バイト）
		DW		512				; 1セクタの大きさ（512にしなければいけない）
		DB		1				; クラスタの大きさ（1セクタにしなければいけない）
		DW		1				; FATがどこから始まるか（普通は1セクタ目からにする）
		DB		2				; FATの個数（2にしなければいけない）
		DW		224				; ルートディレクトリ領域の大きさ（普通は224エントリにする）
		DW		2880			; このドライブの大きさ（2880セクタにしなければいけない）
		DB		0xf0			; メディアのタイプ（0xf0にしなければいけない）
		DW		9				; FAT領域の長さ（9セクタにしなければいけない）
		DW		18				; 1トラックにいくつのセクタがあるか（18にしなければいけない）
		DW		2				; ヘッドの数（2にしなければいけない）
		DD		0				; パーティションを使ってないのでここは必ず0
		DD		2880			; このドライブ大きさをもう一度書く
		DB		0,0,0x29		; よくわからないけどこの値にしておくといいらしい
		DD		0xffffffff		; たぶんボリュームシリアル番号
		DB		"HELLO-OS   "	; ディスクの名前（11バイト）
		DB		"FAT12   "		; フォーマットの名前（8バイト）
		RESB	18				; とりあえず18バイトあけておく

; プログラム本体

entry:
		MOV		AX,0			; レジスタ初期化 ;初始化暫存器 AX=0 AX:accumulator, 累加暫存器
		MOV		SS,AX 			; SS = AX  MOV==COPY
		MOV		SP,0x7c00		; SP=stack pointer, 棧指針暫存器
		MOV		DS,AX
		MOV		ES,AX

		MOV		SI,msg 			;msg=Ox7c74
putloop:
		MOV		AL,[SI]			AL=[外部暫存器,位置si=Ox7c74的資料]
		ADD		SI,1			; SIに1を足す 把SI+1
		CMP		AL,0			;if AL==0 跳去 fin
		JE		fin
		MOV		AH,0x0e			; 一文字表示ファンクション ;顯是一個文字
		MOV		BX,15			; カラーコード ;指定字符顏色
		INT		0x10			; ビデオBIOS呼び出し ;條用顯?BIOS
		JMP		putloop
fin:
		HLT						; 何かあるまでCPUを停止させる ;讓CPU stop 等待指令
		JMP		fin				; 無限ループ ;無限循環 jump 到fin(finish)

msg:
		DB		0x0a, 0x0a		; 改行を2つ ;換行2次
		DB		"hello, world"
		DB		0x0a			; 改行 ;換行
		DB		0

		RESB	0x7dfe-$		; 0x7dfeまでを0x00で埋める命令

		DB		0x55, 0xaa

; 以下はブートセクタ以外の部分の記述

		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
		RESB	4600
		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
		RESB	1469432


;;;;
; MOV WORD [678],123 123是word(16位)，[678]外部暫存器只有8位(BYTE)，故123的16進位前8位放在[679]
; MOV byte , byte Ok! // MOV byte, word No!