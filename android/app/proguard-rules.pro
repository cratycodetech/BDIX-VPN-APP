# Keep MainActivity and network-related classes
-keep class com.example.bdix_vpn.MainActivity { *; }
-keep class * extends io.flutter.plugin.common.MethodChannel { *; }
-keep class * implements android.net.ConnectivityManager$NetworkCallback { *; }

# Flutter engine classes
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.** { *; }