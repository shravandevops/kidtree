pipeline {
    agent any

    environment {
        // Define environment variables if needed
        SONAR_HOST_URL = 'http://13.211.153.80:9000'
    }

    stages {
        stage('Checkout') {
            steps {
                // Pull code from GitHub repository using System Default Git installation
                git branch: 'main', url: 'https://github.com/shravandevops/kidtree.git'
            }
        }

        stage('Build') {
            steps {
                // Build the project using Maven
                sh 'mvn clean install'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                // Run SonarQube analysis on the project
                withSonarQubeEnv('SonarQubeServer') {
                    sh "mvn sonar:sonar -Dsonar.host.url=${SONAR_HOST_URL}"
                }
            }
        }
    }
}
