allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    afterEvaluate {
        // 为所有 Android 库项目自动设置 namespace（从 AndroidManifest.xml 读取）
        if (project.plugins.hasPlugin("com.android.library")) {
            val android = project.extensions.findByName("android")
            if (android != null) {
                try {
                    val manifestFile = project.file("src/main/AndroidManifest.xml")
                    if (manifestFile.exists()) {
                        val manifestContent = manifestFile.readText()
                        val packageMatch = Regex("package=\"([^\"]+)\"").find(manifestContent)
                        if (packageMatch != null) {
                            val namespace = packageMatch.groupValues[1]
                            // 使用 Groovy 动态调用设置 namespace
                            val setNamespaceMethod = android.javaClass.methods.find { 
                                it.name == "setNamespace" && it.parameterCount == 1 
                            }
                            if (setNamespaceMethod != null) {
                                setNamespaceMethod.invoke(android, namespace)
                            }
                        }
                    }
                } catch (e: Exception) {
                    // 忽略错误，继续构建
                }
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
