repositories {
    mavenCentral()
}

plugins {
    scala
    application
}

scala {
    scalaVersion = "2.12.20"
}

application {
    mainClass = "com.example.Playground"
}