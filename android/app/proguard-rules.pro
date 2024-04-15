#-keepclasseswithmembernames,includedescriptorclasses class * {
#    native <methods>;
#}

##---------------Begin: proguard configuration for VK  ----------
-keep class com.vk.** { *; }
##---------------End: proguard configuration for VK  ----------
#
#-keepclassmembers class ai.deepar.ar.DeepAR { *; }
#-keepclassmembers class ai.deepar.ar.core.videotexture.VideoTextureAndroidJava { *; }
#-keep class ai.deepar.ar.core.videotexture.VideoTextureAndroidJava


-keep class **.zego.**{*;}

