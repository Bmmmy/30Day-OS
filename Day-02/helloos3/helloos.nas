; hello-os 
; TAB=4

		ORG		0x7c00			; ���̃v���O�������ǂ��ɓǂݍ��܂��̂� ; ���inask�݊J�n���s���c�����@��ꌾ�w���䓞?�����I?�n���B 
		;�nOx7c00�J�n  $:�A�o���������� -->�v椓��I?���n��

; �ȉ��͕W���I��FAT12�t�H�[�}�b�g�t���b�s�[�f�B�X�N�̂��߂̋L�q �ȉ��חp���W��FAT12�I��?��

		JMP		entry	;�W�ܓI�ߖ� �w��JMP�I���z�ړI�� == JMP Ox7c50 entry=Ox7c50
		DB		0x90
		DB		"HELLOIPL"		; �u�[�g�Z�N�^�̖��O�����R�ɏ����Ă悢�i8�o�C�g�j
		DW		512				; 1�Z�N�^�̑傫���i512�ɂ��Ȃ���΂����Ȃ��j
		DB		1				; �N���X�^�̑傫���i1�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DW		1				; FAT���ǂ�����n�܂邩�i���ʂ�1�Z�N�^�ڂ���ɂ���j
		DB		2				; FAT�̌��i2�ɂ��Ȃ���΂����Ȃ��j
		DW		224				; ���[�g�f�B���N�g���̈�̑傫���i���ʂ�224�G���g���ɂ���j
		DW		2880			; ���̃h���C�u�̑傫���i2880�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DB		0xf0			; ���f�B�A�̃^�C�v�i0xf0�ɂ��Ȃ���΂����Ȃ��j
		DW		9				; FAT�̈�̒����i9�Z�N�^�ɂ��Ȃ���΂����Ȃ��j
		DW		18				; 1�g���b�N�ɂ����̃Z�N�^�����邩�i18�ɂ��Ȃ���΂����Ȃ��j
		DW		2				; �w�b�h�̐��i2�ɂ��Ȃ���΂����Ȃ��j
		DD		0				; �p�[�e�B�V�������g���ĂȂ��̂ł����͕K��0
		DD		2880			; ���̃h���C�u�傫����������x����
		DB		0,0,0x29		; �悭�킩��Ȃ����ǂ��̒l�ɂ��Ă����Ƃ����炵��
		DD		0xffffffff		; ���Ԃ�{�����[���V���A���ԍ�
		DB		"HELLO-OS   "	; �f�B�X�N�̖��O�i11�o�C�g�j
		DB		"FAT12   "		; �t�H�[�}�b�g�̖��O�i8�o�C�g�j
		RESB	18				; �Ƃ肠����18�o�C�g�����Ă���

; �v���O�����{��

entry:
		MOV		AX,0			; ���W�X�^������ ;���n���b���� AX=0 AX:accumulator, �݉��b����
		MOV		SS,AX 			; SS = AX  MOV==COPY
		MOV		SP,0x7c00		; SP=stack pointer, ���w�j�b����
		MOV		DS,AX
		MOV		ES,AX

		MOV		SI,msg 			;msg=Ox7c74
putloop:
		MOV		AL,[SI]			AL=[�O���b����,�ʒusi=Ox7c74�I����]
		ADD		SI,1			; SI��1�𑫂� �cSI+1
		CMP		AL,0			;if AL==0 ���� fin
		JE		fin
		MOV		AH,0x0e			; �ꕶ���\���t�@���N�V���� ;���������
		MOV		BX,15			; �J���[�R�[�h ;�w�莚�����F
		INT		0x10			; �r�f�IBIOS�Ăяo�� ;���p��?BIOS
		JMP		putloop
fin:
		HLT						; ��������܂�CPU���~������ ;�CPU stop ���Ҏw��
		JMP		fin				; �������[�v ;�����z�� jump ��fin(finish)

msg:
		DB		0x0a, 0x0a		; ���s��2�� ;���s2��
		DB		"hello, world"
		DB		0x0a			; ���s ;���s
		DB		0

		RESB	0x7dfe-$		; 0x7dfe�܂ł�0x00�Ŗ��߂閽��

		DB		0x55, 0xaa

; �ȉ��̓u�[�g�Z�N�^�ȊO�̕����̋L�q

		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
		RESB	4600
		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
		RESB	1469432


;;;;
; MOV WORD [678],123 123��word(16��)�C[678]�O���b������L8��(BYTE)�C��123�I16�i�ʑO8�ʕ���[679]
; MOV byte , byte Ok! // MOV byte, word No!