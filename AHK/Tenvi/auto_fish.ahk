#NoEnv
#SingleInstance Force
SetBatchLines, -1  ; ���ýű���Ӧ�ٶ�
SetStoreCapsLockMode, Off

; ����������������Ϲ���ͼ���ļ�
search_top := 700
search_left := 0
search_bottom := 1100
search_right := 2100
fish_images := ["fish_eating1.bmp", "fish_eating2.bmp", "fish_eating3.bmp", "fish_eating4.bmp", "fish_eating5.bmp", "fish_eating6.bmp"]

flg = 0

^f::
    DllCall("QueryPerformanceFrequency", "Int64*", QuadPart)

    ; ȫ�Զ���������
    Loop
    {
        ; �׸Ͳ���
        Send, d  ; ���� 'd' ���׸�
        ToolTip, Casting rod... ; ��ʾ�׸Ͳ���
        Sleep, 1000  ; �ȴ��׸Ͷ������

        ; �������ȴ�ʱ�䣬�����ж��Ƿ�ɹ��׸�
        start_time := A_TickCount
        fish_caught := false  ; ����Ƿ��⵽���Ϲ�

        ; ������Ƿ��Ϲ�
        Loop
        {
            ToolTip, Checking for fish...

            ; ��������ͼ���ļ���������
            for index, fish_image in fish_images
            {
                ImageSearch, FoundX, FoundY, search_left, search_top, search_right, search_bottom, *97 %fish_image%
                if (ErrorLevel = 0)
                {
                    Send, v  ; �ո�
                    ToolTip, Fish Hooked!
                    Sleep, 100  ; �ȴ��ո˶������
                    fish_caught := true
                    break
                }
            }

            ; �����δ�Ϲ�����鳬ʱ���ƣ���Ϊ�׸�ʧ��
            if (A_TickCount - start_time > 12000)  ; ����12��δ��⵽�㣬��Ϊ�׸�ʧ��
            {
                ToolTip, Failed to catch fish _ retrying ; ��ʾ������Ϣ
                Send, d  ; �����׸�
                break
            }

            ; ���ɹ���׽���㣬�˳�ѭ��
            if (fish_caught)
                break
        }
    }