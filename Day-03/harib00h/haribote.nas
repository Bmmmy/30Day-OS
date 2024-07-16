; haribote-os
; TAB=4

; BOOT_INFO�֌W
CYLS	EQU		0x0ff0			; �u�[�g�Z�N�^���ݒ肷��
LEDS	EQU		0x0ff1
VMODE	EQU		0x0ff2			; �F���Ɋւ�����B���r�b�g�J���[���H (�L����F�ɖړI�u�� ���F�I�ʝ�)
SCRNX	EQU		0x0ff4			; �𑜓x��X ;�������Ix(screen x)
SCRNY	EQU		0x0ff6			; �𑜓x��Y ;�������Iy(screen y)
VRAM	EQU		0x0ff8			; �O���t�B�b�N�o�b�t�@�̊J�n�Ԓn ;�����ɏՙ��I�J�n�n�� �����`�ʓI?��

		ORG		0xc200			; ���̃v���O�������ǂ��ɓǂݍ��܂��̂� ;���������v����ړ�?���I�I�r���n��

		MOV		AL,0x13			; VGA�O���t�B�b�N�X�A320x200x8bit�J���[ ;vag��?, 320*320�ʍʐF
		MOV		AH,0x00
		INT		0x10
		MOV		BYTE [VMODE],8	; ��ʃ��[�h���������� ;�L?�`�ʖ͎�
		MOV		WORD [SCRNX],320
		MOV		WORD [SCRNY],200
		MOV		DWORD [VRAM],0x000a0000

; �L�[�{�[�h��LED��Ԃ�BIOS�ɋ����Ă��炤 ;�pbios�擾���Տ�e��LED�w�����I?��

		MOV		AH,0x02
		INT		0x16 			; keyboard BIOS
		MOV		[LEDS],AL

fin:
		HLT
		JMP		fin
