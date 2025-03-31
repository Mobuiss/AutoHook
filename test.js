var targetClassName = "sg.vantagepoint.uncrackable1.MainActivity$1"
// function ListClassLoader() {
//     Java.enumerateClassLoaders({
//         onMatch: function (loader) {
//             //console.log("loader : " + loader);
//             try {
//                 if (loader.findClass(targetClassName)) {
//                     console.log("find loader : " + loader);
//                     //Java.classFactory.loader = loader
//                 }
//             } catch (err) {

//             }
//         },
//         onComplete: function () {
//             console.log("[*] Enumeration complete.");
//         }
//     })
// }
// function ListClass() {
//     Java.enumerateLoadedClasses({
//         onMatch: function (className) {
//             // console.log(className);
//             if (className.includes("sg.vantagepoint")) {
//                 console.log("found class : " + className);
//                 // var clazz = Java.use(className)
//                 // var loader = clazz.class.getClassLoader()
//                 // console.log(loader)
//             }

//         },
//         onComplete: function () {
//             console.log("done");
//         }
//     })
// }
function main() {
    Java.perform(function () {

        var orgfuc = Java.use(targetClassName)
        console.log(orgfuc.class.getClassLoader())
        var DexClassLoader = Java.use('dalvik.system.DexClassLoader');
        var customDexPath = "/data/local/tmp/out.dex";  // android端你的修改后 DEX文件 的路径
        var optimizedDir = "/data/local/tmp/cache";
        // ListClassLoader();
        // 使用 DexClassLoader 加载新的 dex
        var customClassLoader = DexClassLoader.$new(customDexPath, optimizedDir, null, null);
        var myfuc = Java.ClassFactory.get(customClassLoader).use(targetClassName);
        orgfuc.onClick.overload('android.content.DialogInterface', 'int').implementation = function (arg1, arg2) {
            return myfuc.onClick(arg1, arg2);
        }
        console.log(orgfuc.class.getClassLoader())
    })

}
setTimeout(main, 0)