; haribote-os
; TAB=4

; BOOT_INFO関係
CYLS	EQU		0x0ff0			; ブートセクタが設定する
LEDS	EQU		0x0ff1
VMODE	EQU		0x0ff2			; 色数に関する情報。何ビットカラーか？ (有關顏色數目的訊息 顏色的位數)
SCRNX	EQU		0x0ff4			; 解像度のX ;分辨率的x(screen x)
SCRNY	EQU		0x0ff6			; 解像度のY ;分辨率的y(screen y)
VRAM	EQU		0x0ff8			; グラフィックバッファの開始番地 ;圖像緩衝區的開始地址 顯示畫面的?存

		ORG		0xc200			; このプログラムがどこに読み込まれるのか ;這個程序將要被裝載到?存的的甚麼地方

		MOV		AL,0x13			; VGAグラフィックス、320x200x8bitカラー ;vag顯?, 320*320位彩色
		MOV		AH,0x00
		INT		0x10
		MOV		BYTE [VMODE],8	; 画面モードをメモする ;記?畫面模式
		MOV		WORD [SCRNX],320
		MOV		WORD [SCRNY],200
		MOV		DWORD [VRAM],0x000a0000

; キーボードのLED状態をBIOSに教えてもらう ;用bios取得鍵盤上各種LED指示燈的?態

		MOV		AH,0x02
		INT		0x16 			; keyboard BIOS
		MOV		[LEDS],AL

fin:
		HLT
		JMP		fin
