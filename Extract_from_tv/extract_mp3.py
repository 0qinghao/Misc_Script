import sys
import os
import glob

path = sys.path[0]
os.chdir(path)
for tv_file in glob.glob("*.tv"):
    print(tv_file)
    f = open(path + '/' + tv_file, "rb")

    abs_offset = 0
    start_offset = 0
    f.seek(0, 2)
    size = f.tell()
    f.seek(0)

    while 1:
        f.seek(abs_offset)
        buf = f.read()
        id3v2_offset = buf.find(b'\x49\x44\x33\x02')
        id3v3_offset = buf.find(b'\x49\x44\x33\x03')
        id3v4_offset = buf.find(b'\x49\x44\x33\x04')

        if id3v2_offset != -1:
            start_offset = id3v2_offset
        elif id3v3_offset != -1:
            start_offset = id3v3_offset
        elif id3v4_offset != -1:
            start_offset = id3v4_offset
        else:
            break

        f.seek(abs_offset + start_offset)
        buf = f.read()
        end_offset = buf.find(b'\x54\x41\x47')

        mp3_start = abs_offset + start_offset
        mp3_end = abs_offset + start_offset + end_offset + 127

        while 1:
            f.seek(mp3_end-127)
            End_TAG_0_Cnt = 0
            for i in range(1, 128):
                buf = f.read(1)
                End_TAG_0_Cnt += (buf == b'\x00')
            if End_TAG_0_Cnt < 8:
                print("This chunk may be error, please check:")
                f.seek(mp3_end)
                buf = f.read()
                end_offset = buf.find(b'\x54\x41\x47')
                mp3_end += end_offset + 127
            else:
                break

        print('find mp3, start_offset:', mp3_start,
              "end_offset", mp3_end)
        f_wr = open(path + "/" + tv_file + "_" + str(mp3_start) +
                    "_" + str(mp3_end) + ".mp3", "wb+")
        f.seek(mp3_start)
        buf = f.read(mp3_end - mp3_start + 1)
        f_wr.write(buf)
        f_wr.close()

        abs_offset = mp3_end

    f.close()
