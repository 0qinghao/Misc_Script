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
channel_switch_interval := 120 ; �����л�Ƶ�������ڣ���λ���룩������Ϊ 0 ��ʾ���л�Ƶ��

^f::
    ; ��ȡ��ʼʱ�䣬��¼���ڵĿ�ʼ
    last_switch_time := A_TickCount

    Loop
    {
        ; ����趨��Ƶ���л����ڴ���0�������Ƿ񵽴��л�Ƶ����ʱ��
        if (channel_switch_interval > 0 && A_TickCount - last_switch_time > channel_switch_interval * 1000)
        {
            ; �л�Ƶ������
            ToolTip, Switching channel...
            Send, {Esc}  ; ���� ESC ��
            Sleep, 300
            Send, {Enter}  ; ���� Enter ��
            Sleep, 300
            Send, {Right}  ; �����ҷ����
            Sleep, 300
            Send, {Enter}  ; ���� Enter ��
            ToolTip, Channel switched! ; ��ʾƵ���л��ɹ�
            Sleep, 1000

            ; ��������л�ʱ��
            last_switch_time := A_TickCount
        }

        ; �׸Ͳ���
        Send, d  ; ���� 'd' ���׸�
        ToolTip, Casting rod... ; ��ʾ�׸Ͳ���
        Sleep, 1000  ; �ȴ��׸Ͷ������

        ; �������ȴ�ʱ�䣬�����ж��Ƿ�ɹ��׸�
        start_time := A_TickCount

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

                    ; ����ʰȡ����
                    ToolTip, Picking up the fish...
                    Send, {Space}  ; ���¿ո��ʰȡ
                    ToolTip, Fish picked up! ; ��ʾ�ɹ�ʰȡ

                    break 2  ; ֱ���˳�����ѭ��
                }
            }

            ; �����ʱδ��⵽�㣬�����׸�
            if (A_TickCount - start_time > 12000)  ; ����12��δ��⵽��
            {
                ToolTip, Failed to catch fish _ retrying ; ��ʾ������Ϣ
                break
            }
        }
    }
