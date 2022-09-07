;#include <FindText>
;Text:="|<auto>*159$40.0000k000003000000A00DVUnw7lr6371nUAMAA630FUkkkAT63330rgMAAA1kFUkkkD363330wAAAA62vkvkkQtt1v1kS8" ; Image of the "auto" part in "autohotkey.com". Id of the image is "auto" (between < and > characters).
;ok := FindText(outX, outY,,,,,,,Text) ; Call FindText to look for the "auto" image. outX and outY will be set to X and Y coordinates for the first found result. Search range coordinates, err1 and err0 are left empty to use the default values (searching the whole screen, and looking for an exact match). Results will be stored in the "ok" variable.
;if ok { ; Check if "ok" is not set to 0
;    MsgBox, The image (Text) was first found at coordinates X: %outX% Y: %outY% ; Display outX and outY
;    MsgBox, % ok.MaxIndex() " results were found." ; ok.MaxIndex() and ok.Length() should return how many search results were found.
;    MsgBox, % "The first found image is located at X" ok[1][1] " Y" ok[1][2] ". It has a width of " ok[1][3] " and a height of " ok[1][4] ". Additionally it has a id of " ok[1].id
;    if ok[2] ; ok[1] contains the first result, ok[2] contains the second result, etc... Check if ok[2] exists and if yes, display some of its contents.
;        MsgBox, % "The second found image is located at X" ok[2][1] " Y" ok[2][2] " and it has a width of " ok[2][3] " and a height of " ok[2][4] ". Additionally it has a comment text of " ok[2].id
;} else {
;    MsgBox, The image/Text was not found. Is everything set up correctly and the image is visible in Paint? ; It seems "ok" was left empty, so nothing was found.
;}



;#include <FindText>

;if (ok := FindText(outX, outY, 0, 0, A_ScreenWidth, A_ScreenHeight, 0.05, 0.05, "|<auto>*159$40.0000k000003000000A00DVUnw7lr6371nUAMAA630FUkkkAT63330rgMAAA1kFUkkkD363330wAAAA62vkvkkQtt1v1kS8")) { ; Call FindText to look for the "auto" image. outX and outY will be set to X and Y coordinates for the first found result. Search ranges top left corner is (0;0) and bottom right corner (A_ScreenWidth; A_ScreenHeight), which should search the whole screen, but might not work properly if using multiple monitors. Error margins are set to 5% for both "1"s and "0"s. Results will be stored in the "ok" variable. If "ok" contains results, then the "if" condition will be successful.
;    for k, v in ok { ; Loop over all the search results in "ok". "k" will be the nth result, and "v" will contain the result itself.
;        MsgBox, % "Result number " k " is located at X" v[1] " Y" v[2] " and it has a width of " v[3] " and a height of " v[4] ". Additionally it has a comment text of " v.id ; v[1] is equivalent to ok[k][1], v.id is equivalent to ok[k].id, and so on.
;    }
;} else {
;    MsgBox, The image/Text was not found. Is everything set up correctly and the image is visible in Paint? ; It seems "ok" was left empty, so nothing was found.
;}



#include <FindText>
Text:="|<auto>*159$40.0000k000003000000A00DVUnw7lr6371nUAMAA630FUkkkAT63330rgMAAA1kFUkkkD363330wAAAA62vkvkkQtt1v1kS8" ; Image of the "auto" part in "autohotkey.com". Id of the image is "auto" (between < and > characters).
Text.="|<hot>*152$29.U00010000200014000280004Hk7kzxktktVVUkX161V43A3286M24EAkA8UNUMF0lUUW1Xb1g31s1s" ; Append an image of the "hot" part in "autohotkey.com" to the Text variable (note the ".=" operator which appends, when previously we used ":=" to set). Id of the image is "hot".
; The last two lines are the same as Text:="|<auto>*159$40.0000k000003000000A00DVUnw7lr6371nUAMAA630FUkkkAT63330rgMAAA1kFUkkkD363330wAAAA62vkvkkQtt1v1kS8|<hot>*152$29.U00010000200014000280004Hk7kzxktktVVUkX161V43A3286M24EAkA8UNUMF0lUUW1Xb1g31s1s"

WinGetPos, pX, pY, pW, pH, ahk_class MSPaintApp ; Get the Paint application location and size.

if !(ok := FindText(X, Y, pX, pY, pX+pW, pY+pH, 0.000001,, Text)) { ; Call FindText to look for either "auto" or "hot" images. X and Y will be set to X and Y coordinates for the first found result. The search range will be only the Paint application. Setting one or both of the error margins to a small non-zero value will avoid the second search with 5% error margins. Results will be stored in the "ok" variable. If "ok" doesn't contain anything ("!" is the "not" operator) then exit, otherwise continue on.
    MsgBox, The image/Text was not found. Is everything set up correctly and the image is visible in Paint? ; It seems "ok" was left empty, so nothing was found.
    ExitApp
}
; Anything after this part will happen only if any of the Text was found (either "hot" or "auto" image).

for key, value in ok { ; Loop over all the search results in "ok". "key" will be the nth result, and "value" will contain the result itself.
    FindText().MouseTip(value.x, value.y) ; Show a blinking red box at the center of the result.
    MsgBox, % "Result number " key " is located at X" value[1] " Y" value[2] " and it has a width of " value[3] " and a height of " value[4] ". Additionally it has a comment text of " value.id ; value[1] is equivalent to ok[k][1], value.id is equivalent to ok[k].id, and so on.
    if (value.id == "auto")
        MsgBox, Here we found the "auto" image.
}