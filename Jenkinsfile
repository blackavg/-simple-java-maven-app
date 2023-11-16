pipeline {
    agent any

    tools {
        maven "Maven 3.9.5"
        jdk "JDK 17.0.8.1"
    }

    options {
        timeout(time: 10, unit: 'MINUTES')
        skipStagesAfterUnstable()
    }

    stages {
        stage('Compilar & Probar') {
            steps {
                git 'https://github.com/blackavg/-simple-java-maven-app'
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }

            post {
                success {
                    junit '**/target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.jar'
                }
            }
        }
        stage('Analisis SonarQube') {
            steps {
                withSonarQubeEnv('sonarqube_docker') {
                    sh "mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.10.0.2594:sonar -Dsonar.projectKey='PruebaTecnicaDevOPSp' -Dsonar.projectName='PruebaTecnicaDevOPSp'"
                }

            }
        } 
        stage('Crear Docker image') {
            steps {
                sh 'docker build -t simple-java-maven-app .'
            }
        }        
    }
}
