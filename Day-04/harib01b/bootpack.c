void io_hlt(void);
void write_mem8(int addr, int data);


void HariMain(void)
{
	int i; /* 変数宣言。iという変数は、32ビットの整数型 */

	for (i = 0xa0000; i <= 0xaffff; i++) {
		write_mem8(i, i & 0x0f); // &-->and
	}

	for (;;) {
		io_hlt();
	}
}
