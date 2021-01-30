@REM to create junction (mirror folder) execute this
rmdir backend\public
rmdir frontend\my_school_web\lib\common
rmdir frontend\my_school_android\lib\common
mklink /J backend\public frontend\my_school_web\build\web\
mklink /J frontend\my_school_web\lib\common frontend\common\lib\
mklink /J frontend\my_school_android\lib\common frontend\common\lib\
PAUSE