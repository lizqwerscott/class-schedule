# RC4加密算法
def do_encrypt_rc4(src: str, passwd: str) -> str:
    i, j, a, b, c = 0, 0, 0, 0, 0
    key, sbox = [], []
    plen = len(passwd)
    size = len(src)
    output = ""
    for i in range(256):
        key.append(ord(passwd[i % plen]))
        sbox.append(i)
    # 状态向量打乱
    for i in range(256):
        j = (j + sbox[i] + key[i]) % 256
        temp = sbox[i]
        sbox[i] = sbox[j]
        sbox[j] = temp
    # 秘钥流的生成与加密
    for i in range(size):
        a = (a + 1) % 256
        b = (b + sbox[a]) % 256
        temp = sbox[a]
        sbox[a] = sbox[b]
        sbox[b] = temp
        c = (sbox[a] + sbox[b]) % 256
        # 明文字节由子密钥异或加密
        temp = ord(src[i]) ^ sbox[c]
        # 密文字节转换成hex，格式对齐修正（取最后两位，若为一位（[0x0，0xF]），则改成[00, 0F]）
        temp = str(hex(temp))[-2:]
        temp = temp.replace('x', '0')
        # 输出
        output += temp
    return output

if __name__ == "__main__":
    x = do_encrypt_rc4("hello", "12138")
    print(x)
