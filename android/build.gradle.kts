import com.android.build.gradle.LibraryExtension
import com.android.build.gradle.AppExtension
import com.android.build.gradle.LibraryPlugin
import com.android.build.gradle.AppPlugin

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
    project.plugins.whenPluginAdded {
        if (this.javaClass.name.contains("com.android.build.gradle.LibraryPlugin") || 
            this.javaClass.name.contains("com.android.build.gradle.AppPlugin")) {
            project.extensions.getByName("android").apply {
                if (this is com.android.build.gradle.BaseExtension) {
                    if (this.namespace == null) {
                        this.namespace = "com.gymtrack.personal.${project.name.replace('-', '_')}"
                    }
                }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
