; naskfunc
; TAB=4

[FORMAT "WCOFF"]				; �I�u�W�F�N�g�t�@�C������郂�[�h	����ڕW�����I�͎�
[BITS 32]						; 32�r�b�g���[�h�p�̋@�B�����点�� ����32�ʖ͎��p�I�@��ꌾ


; �I�u�W�F�N�g�t�@�C���̂��߂̏�� ����ڕW�����I�u��

[FILE "naskfunc.nas"]			; �\�[�X�t�@�C������� ���������u��

		GLOBAL	_io_hlt			; ���̃v���O�����Ɋ܂܂��֐��� ��������ܓI���ɖ�


; �ȉ��͎��ۂ̊֐�

[SECTION .text]		; �I�u�W�F�N�g�t�@�C���ł͂���������Ă���v���O�����������ڕW���������������ݛ�����

_io_hlt:	; void io_hlt(void);
		HLT
		RET
