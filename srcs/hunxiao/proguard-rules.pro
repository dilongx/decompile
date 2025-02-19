# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-optimizationpasses 5
##打印混淆的详细信息
#-verbose
##声明不压缩输入文件。
#-dontshrink
 # 不进行预校验,Android不需要,可加快混淆速度。
-dontpreverify
#将次选项去除，可以混淆时进行优化
-dontoptimize
# 屏蔽警告
-ignorewarnings
# 混淆时不会产生形形色色的类名(混淆时不使用大小写混合类名)
-dontusemixedcaseclassnames
# 指定不去忽略非公共的库类(不跳过library中的非public的类)
-dontskipnonpubliclibraryclasses
# 指定不去忽略包可见的库类的成员
-dontskipnonpubliclibraryclassmembers
# 保护代码中的Annotation不被混淆
-keepattributes *Annotation*
# 避免混淆泛型, 这在JSON实体映射时非常重要
-keepattributes Signature
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*

-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.app.job.JobService
-keep public class * extends android.accessibilityservice.AccessibilityService
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class com.android.vending.licensing.ILicensingService
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
-keepclassmembers class * {
   public <init>(org.json.JSONObject);
}
#################################################################
########################### SDK保持不混淆 ############################
#################################################################


# 打通所有的包
-repackageclass com.yhao.floatwindow
# 混淆到包名下
-dontwarn com.yhao.floatwindow.**
# 保证API不混淆
-keep class com.yhao.floatwindow.FloatActivity{*;}
-keep class com.yhao.floatwindow.FloatWindow{*;}
-keep class com.yhao.floatwindow.FloatWindow$Builder{*;}
-keep class com.yhao.floatwindow.annotation.MoveType{*;}
-keep class com.yhao.floatwindow.annotation.Screen{*;}
-keep class com.yhao.floatwindow.permission.PermissionUtil{*;}
-keep class com.yhao.floatwindow.interfaces.BaseFloatWindow{*;}


#################################################################
########################### 文件名字混淆 ############################
#################################################################
-obfuscationdictionary proguards/proguard-socialism.txt
-classobfuscationdictionary proguards/proguard-socialism.txt
-packageobfuscationdictionary proguards/proguard-socialism.txt
