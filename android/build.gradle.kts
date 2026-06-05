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
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// 强制所有子项目（含插件）使用 compileSdk 36
subprojects {
    project.plugins.withId("com.android.application") {
        project.extensions.getByType(com.android.build.api.dsl.ApplicationExtension::class.java).compileSdk = 36
    }
    project.plugins.withId("com.android.library") {
        project.extensions.getByType(com.android.build.api.dsl.LibraryExtension::class.java).compileSdk = 36
    }
}
